module ActiveCucumber

  # Creates ActiveRecord entries
  class Cureator

    # Returns the Cureator instance for the given ActiveRecord class.
    def self.for activerecord_class
      cureator_class(activerecord_class).new activerecord_class
    end


    def initialize activerecord_class
      @clazz = activerecord_class
    end


    # Creates all entries in the given Cucumber table
    #
    # Assumes a horizontal Cucumber table.
    def create_records table
      table.map do |row|
        create_record row
      end
    end


    # Creates a new record in the database,
    # of the given class, with the given Cucumber-formatted String attributes.
    def create_record attributes
      FactoryGirl.create @clazz, factorygirl_row(symbolized_hash(attributes))
    end


  private

    # Returns the Cucumberator subclass to be used by this Cucumparer instance
    def self.cureator_class activerecord_class
      cureator_class_name(activerecord_class).constantize
    rescue NameError
      Cureator
    end


    # Returns the name of the Cucumberator subclass to be used by this Cucumparer instance.
    def self.cureator_class_name activerecord_class
      "#{activerecord_class.name}Cureator"
    end


    # Returns the given row, with values converted to FactoryGirl format
    #
    # Assumes the keys of the row are hashes
    def factorygirl_row row
      {}.tap do |result|
        row.each do |key, value|
          method = method_name key
          result[key] = respond_to?(method) ? send(method, value) : value
        end
      end
    end


    # Returns the name of the value_for method for the given key
    def method_name key
      "value_for_#{key}"
    end


    # Converts the key given in Cucumber format into FactoryGirl format
    def normalized_key key
      key.downcase.parameterize.underscore
    end


    # Returns a new hash with the keys normalized to symbols
    def symbolized_hash row
      {}.tap do |result|
        row.each do |key, value|
          result[normalized_key key] = value
        end
      end
    end

  end

end
