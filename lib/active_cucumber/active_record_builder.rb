module ActiveCucumber

  # Creates ActiveRecord entries with data from given Cucumber tables.
  class ActiveRecordBuilder

    def initialize activerecord_class, context
      @clazz = activerecord_class
      @creator_class = creator_class
      @context = context
    end


    # Creates all entries in the given horizontal table hash
    def create_many table
      table.map do |row|
        create_record row
      end
    end


    # Creates a new record with the given attributes in the database
    def create_record attributes
      creator = @creator_class.new attributes, @context
      FactoryGirl.create @clazz, creator.factorygirl_attributes
    end


  private

    # Returns the Cucumberator subclass to be used by this Cucumparer instance
    def creator_class
      creator_class_name.constantize
    rescue NameError
      Creator
    end


    # Returns the name of the Cucumberator subclass to be used by this Cucumparer instance.
    def creator_class_name
      "#{@clazz.name}Creator"
    end

  end

end
