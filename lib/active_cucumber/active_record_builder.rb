# frozen_string_literal: true

module ActiveCucumber
  # Creates ActiveRecord entries with data from given Cucumber tables.
  class ActiveRecordBuilder
    def initialize(activerecord_class, context)
      @activerecord_class = activerecord_class
      @context = context
    end

    def attributes_for(attributes)
      creator_class.new(attributes, @context).factorybot_attributes
    end

    # Creates all entries in the given horizontal table hash
    def create_many(table)
      table.map { |row| create_record(row) }
    end

    # Creates a new record with the given attributes in the database
    def create_record(attributes)
      factory_name = @activerecord_class.name.underscore.to_sym
      create_with_factory(factory_name, factorybot_attributes, attributes)
    end

    private

    # Creates a record using FactoryBot with error handling
    def create_with_factory(factory_name, factorybot_attributes, attributes)
      FactoryBot.create factory_name, factorybot_attributes
    rescue ActiveRecord::RecordInvalid => e
      record = e.record || @activerecord_class.new
      raise ActiveRecord::RecordInvalid, record,
            "Failed to create #{@activerecord_class.name} with attributes " \
            "#{attributes.inspect}: #{e.message}"
    rescue ArgumentError => e
      raise ArgumentError, "Failed to create #{@activerecord_class.name}: #{e.message}. " \
                           "Make sure a FactoryBot factory is defined for :#{factory_name}"
    end

    # Returns the Creator subclass to be used by this ActiveRecordBuilder instance.
    def creator_class
      @creator_class ||= begin
        creator_class_name.constantize
      rescue NameError
        Creator
      end
    end

    # Returns the name of the Creator subclass to be used by this ActiveRecordBuilder instance.
    def creator_class_name
      "#{@activerecord_class.name}Creator"
    end
  end
end
