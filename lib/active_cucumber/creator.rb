module ActiveCucumber

  # Creates ActiveRecord entries with data from given Cucumber tables.
  class Creator

    def initialize activerecord_class
      @clazz = activerecord_class
      @cureator_class = cureator_class
    end


    # Creates all entries in the given horizontal table hash
    def create_many table
      table.map do |row|
        create_record row
      end
    end


    # Creates a new record with the given attributes in the database
    def create_record attributes
      cureator = @cureator_class.new attributes
      FactoryGirl.create @clazz, cureator.factorygirl_attributes
    end


  private

    # Returns the Cucumberator subclass to be used by this Cucumparer instance
    def cureator_class
      cureator_class_name.constantize
    rescue NameError
      Cureator
    end


    # Returns the name of the Cucumberator subclass to be used by this Cucumparer instance.
    def cureator_class_name
      "#{@clazz.name}Cureator"
    end

  end

end
