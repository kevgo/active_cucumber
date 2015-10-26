module ActiveCucumber

  # Creates ActiveRecord entries with data from given Cucumber tables.
  class Creator

    include FactoryGirl::Syntax::Methods

    def initialize attributes
      @attributes = attributes
    end

    # Returns the FactoryGirl version of this Creator's attributes
    def factorygirl_attributes
      symbolize_attributes!
      @attributes.each do |key, value|
        next unless respond_to?(method = method_name(key))
        if (result = send method, value)
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
    def method_name key
      "value_for_#{key}"
    end


    # Converts the key given in Cucumber format into FactoryGirl format
    def normalized_key key
      key.downcase.parameterize.underscore.to_sym
    end


    # Makes the keys on @attributes be normalized symbols
    def symbolize_attributes!
      @attributes = {}.tap do |result|
        @attributes.each do |key, value|
          result[normalized_key key] = value
        end
      end
    end

  end

end
