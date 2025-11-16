# frozen_string_literal: true

require "factory_bot"

module ActiveCucumber
  # Creates ActiveRecord entries with data from given Cucumber tables.
  class Creator
    include FactoryBot::Syntax::Methods

    def initialize(attributes, context)
      @attributes = attributes
      assign_context_variables(context)
    end

    # Returns the FactoryBot version of this Creator's attributes.
    def factorybot_attributes
      normalize_attributes!
      apply_value_transformations!
      @attributes
    end

    private

    # Assigns context hash values as instance variables
    def assign_context_variables(context)
      context.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    # Applies value_for_* transformations to attributes
    def apply_value_transformations!
      original_attributes = @attributes.dup

      original_attributes.each do |key, original_value|
        apply_transformation_for(key, original_value)
      end
    end

    # Applies a single value_for_* transformation for the given key
    def apply_transformation_for(key, original_value)
      transformer_method = "value_for_#{key}"
      return unless respond_to?(transformer_method)

      transformed_value = send(transformer_method, original_value)
      update_or_delete_attribute(key, transformed_value, original_value)
    end

    # Updates or deletes an attribute based on the transformation result
    def update_or_delete_attribute(key, transformed_value, original_value)
      return unless @attributes.key?(key)

      if transformed_value || original_value.nil?
        @attributes[key] = transformed_value
      else
        @attributes.delete(key)
      end
    end

    def method_missing(method_name, *, &)
      if @attributes.respond_to?(method_name, true)
        @attributes.send(method_name, *, &)
      else
        super
      end
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
    def normalize_attributes!
      @attributes = @attributes.each_with_object({}) do |(key, value), result|
        result[normalized_key(key)] = normalized_value(value)
      end
    end
  end
end
