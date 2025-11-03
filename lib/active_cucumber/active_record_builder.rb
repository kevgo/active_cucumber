# frozen_string_literal: true

module ActiveCucumber
  # Creates ActiveRecord entries with data from given Cucumber tables.
  class ActiveRecordBuilder
    # @param activerecord_class [Class] The ActiveRecord class to build instances for
    # @param context [Hash] Optional context values passed to Creator instances
    def initialize(activerecord_class, context)
      @clazz = activerecord_class
      @creator_class = creator_class
      @context = context
    end

    # Builds attributes hash from the given attributes
    #
    # @param attributes [Hash] The raw attributes from a Cucumber table
    # @return [Hash] Processed attributes ready for FactoryBot
    def attributes_for(attributes)
      @creator_class.new(attributes, @context).factorygirl_attributes
    end

    # Creates all entries in the given horizontal table hash
    def create_many(table)
      table.map do |row|
        create_record row
      end
    end

    # Creates a new record with the given attributes in the database
    #
    # @param attributes [Hash] The attributes hash for the record
    # @return [ActiveRecord::Base] The created ActiveRecord instance
    def create_record(attributes)
      creator = @creator_class.new attributes, @context
      FactoryBot.create @clazz.name.underscore.to_sym, creator.factorygirl_attributes
    end

    private

    # Returns the Creator subclass to be used by this ActiveRecordBuilder instance
    def creator_class
      creator_class_name.constantize
    rescue NameError
      Creator
    end

    # Returns the name of the Creator subclass to be used by this ActiveRecordBuilder instance.
    def creator_class_name
      "#{@clazz.name}Creator"
    end
  end
end
