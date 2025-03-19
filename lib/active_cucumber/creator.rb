# frozen_string_literal: true

require 'factory_bot'

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

    # Returns the FactoryBot version of this Creator's attributes
    def factorygirl_attributes
      symbolize_attributes!
      @attributes.each do |key, value|
        next unless respond_to?(method = method_name(key))

        if (result = send method, value) || value.nil?
          @attributes[key] = result if @attributes.key? key
        else
          @attributes.delete key
        end
      end
    end

    private

    def method_missing method_name, *arguments
      # This is necessary so that a Creator subclass can access
      # methods of @attributes as if they were its own.
      @attributes.send method_name, *arguments
    end

    # Returns the name of the value_for method for the given key
    def method_name(key)
      "value_for_#{key}"
    end

    # Converts the key given in Cucumber format into FactoryBot format
    def normalized_key(key)
      key.downcase.parameterize.underscore.to_sym
    end

    def normalized_value(value)
      value.blank? ? nil : value
    end

    # Makes the keys on @attributes be normalized symbols
    def symbolize_attributes!
      @attributes = {}.tap do |result|
        @attributes.each do |key, value|
          result[normalized_key key] = normalized_value value
        end
      end
    end
  end
end
