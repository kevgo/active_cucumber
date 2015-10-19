module ActiveCucumber

  # Compares ActiveRecord objects with Cucumber tables,
  # visualizes the differences intuitively as a Cucumber table diff.
  #
  # Comparing a single record against a vertical Cucumber table:
  #   Cucumparer.diff_one! record, table
  #
  # Verifying all records in the database against a horizontal Cucumber table:
  #   Cucumparer.diff_all! class, table
  #
  # Cucumparer compares only the attributes in the table,
  # and ignores the ones not listed.
  #
  # To customize how attributes of the ActiveRecord object are serialized,
  # you can create a "Cucumberator" decorator for your ActiveRecord classes
  # that defines converter functions for the problematic attributes.
  # Cucumberator automatically uses the decorator for the "User" class
  # if you name it "UserCucumberator".
  class Cucumparer

    def initialize clazz, cucumber_table
      @clazz = clazz
      @cucumber_table = cucumber_table
    end

    # Returns all entries in the database as a horizontal Mortadella table
    def to_horizontal_table
      mortadella = Mortadella::Horizontal.new headers: @cucumber_table.headers
      @clazz.order('created_at ASC').each do |record|
        cucumberator = cucumberator_for record
        mortadella << @cucumber_table.headers.map do |header|
          cucumberator.value_for header
        end
      end
      mortadella.table
    end

    # Returns the given object as a vertical Mortadella table
    def to_vertical_table object
      mortadella = Mortadella::Vertical.new
      cucumberator = cucumberator_for object
      @cucumber_table.rows_hash.each do |key, _|
        mortadella[key] = cucumberator.value_for key
      end
      mortadella.table
    end

  private

    # Returns the Cucumberator subclass to be used by this Cucumparer instance
    def cucumberator_class
      cucumberator_class_name.constantize
    rescue NameError
      Cucumberator
    end

    # Returns the name of the Cucumberator subclass to be used by this Cucumparer instance.
    def cucumberator_class_name
      "#{@clazz.name}Cucumberator"
    end

    # Returns the Cucumberator object for the given ActiveRecord instance
    def cucumberator_for object
      cucumberator_class.new object
    end

  end

end
