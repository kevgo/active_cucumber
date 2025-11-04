# frozen_string_literal: true

module ActiveCucumber
  # A decorator for ActiveRecord objects that adds methods to
  # format record attributes as they are displayed in Cucumber tables.
  #
  # This class is used by default. You can subclass it to create
  # custom Cucumberators for your ActiveRecord classes.
  class Cucumberator
    # object - the instance to decorate
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
    def value_for(key)
      method_name = value_method_name key
      if respond_to? method_name
        send(method_name).to_s
      else
        @object.send(normalized_key(key)).to_s
      end
    end

    private

    def method_missing(method_name, *arguments)
      # This is necessary so that a Cucumberator subclass can access
      # attributes of @object as if they were its own.
      if @object.respond_to?(method_name)
        @object.send(method_name, *arguments)
      else
        super
      end
    end

    # Converts the key given in Cucumber format into the format used to
    # access attributes on an ActiveRecord instance.
    def normalized_key(key)
      key.to_s.downcase.parameterize.underscore
    end

    def respond_to_missing?(method_name, include_private = false)
      @object.respond_to?(method_name, include_private) || super
    end

    # Returns the name of the value_of_* method for the given key
    def value_method_name(key)
      "value_for_#{normalized_key key}"
    end
  end
end
