# frozen_string_literal: true

module ActiveCucumber
  # A decorator for ActiveRecord objects that adds methods to
  # format record attributes as they are displayed in Cucumber tables.
  #
  # This class is used by default. You can subclass it to create
  # custom Cucumberators for your ActiveRecord classes. Define methods
  # named `value_for_<attribute_name>` to customize attribute formatting.
  class Cucumberator
    # @param object [ActiveRecord::Base] The ActiveRecord instance to decorate
    # @param context [Hash] Optional context values that will be set as instance variables
    def initialize(object, context)
      @object = object
      context.each do |key, value|
        instance_variable_set "@#{key}", value
      end
    end

    # Returns the Cucumber value for the given attribute key.
    #
    # If a value_for_* method is not defined for the given key,
    # returns the attribute value of the decorated object,
    # converted to a String.
    #
    # @param key [String, Symbol] The attribute name to get the value for
    # @return [String] The formatted value as a string
    def value_for(key)
      method_name = value_method_name key
      if respond_to? method_name
        send(method_name).to_s
      else
        @object.send(normalized_key(key)).to_s
      end
    end

    private

    def method_missing(method_name)
      # This is necessary so that a Cucumberator subclass can access
      # attributes of @object as if they were its own.
      @object.send method_name
    end

    # Converts the key given in Cucumber format into the format used to
    # access attributes on an ActiveRecord instance.
    def normalized_key(key)
      key.to_s.downcase.parameterize.underscore
    end

    def respond_to_missing? method_name, *arguments
      super
    end

    # Returns the name of the value_of_* method for the given key
    def value_method_name(key)
      "value_for_#{normalized_key key}"
    end
  end
end
