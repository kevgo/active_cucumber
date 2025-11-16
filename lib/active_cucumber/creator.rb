# frozen_string_literal: true

require "factory_bot"

module ActiveCucumber
  # Creates ActiveRecord entries with data from given Cucumber tables.
  class Creator
    include FactoryBot::Syntax::Methods

    def initialize(attributes, context)
      @attributes = attributes
      context.each do |key, value|
        instance_variable_set "@#{key}", value
      end
    end

    # Returns the FactoryBot version of this Creator's attributes.
    def factorybot_attributes
      symbolize_attributes!
      # Capture original keys and values before any transformations
      # to ensure each value_for_* method receives the original value
      original_attributes = @attributes.dup
      keys_to_process = original_attributes.keys
      keys_to_process.each do |key|
        method = method_name(key)
        next unless respond_to?(method)

        value = original_attributes[key]
        result = send(method, value)

        # Keep the transformed value if it's truthy or if the original was nil
        # Check if key still exists (value_for_* method may have deleted it)
        if result || value.nil?
          @attributes[key] = result if @attributes.key?(key)
        else
          @attributes.delete(key)
        end
      end
      @attributes
    end

    private

    def method_missing(method_name, *, &)
      # This is necessary so that a Creator subclass can access
      # methods of @attributes as if they were its own.
      if @attributes.respond_to?(method_name, true)
        @attributes.send(method_name, *, &)
      else
        super
      end
    end

    # Returns the name of the value_for method for the given key
    def method_name(key)
      "value_for_#{key}"
    end

    # Converts the key given in Cucumber format into FactoryBot format
    def normalized_key(key)
      key.to_s.downcase.parameterize.underscore.to_sym
    end

    # Converts blank values to nil for consistency
    def normalized_value(value)
      return nil if value.nil?
      return nil if value.respond_to?(:blank?) && value.blank?

      value
    end

    def respond_to_missing?(method_name, include_private = false)
      @attributes.respond_to?(method_name, include_private) || super
    end

    # Normalizes keys to symbols and blank values to nil
    def symbolize_attributes!
      @attributes = {}.tap do |result|
        @attributes.each do |key, value|
          result[normalized_key key] = normalized_value value
        end
      end
    end
  end
end
