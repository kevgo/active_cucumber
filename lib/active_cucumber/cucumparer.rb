# frozen_string_literal: true

module ActiveCucumber
  # Converts database content to Mortadella tables for comparison with Cucumber tables.
  class Cucumparer
    def initialize(database_content, cucumber_table, context)
      @database_content = database_content
      @cucumber_table = cucumber_table
      @context = context
    end

    # Returns all entries in the database as a horizontal Mortadella table
    def to_horizontal_table
      raise ArgumentError, "No headers provided in Cucumber table" if @cucumber_table.headers.empty?

      mortadella = Mortadella::Horizontal.new headers: @cucumber_table.headers
      @database_content = @database_content.all if @database_content.respond_to? :all
      @database_content.each do |record|
        cucumberator = cucumberator_for record
        mortadella << @cucumber_table.headers.map do |header|
          cucumberator.value_for header
        end
      end
      mortadella.table
    end

    # Returns the given object as a vertical Mortadella table
    def to_vertical_table(object)
      mortadella = Mortadella::Vertical.new
      cucumberator = cucumberator_for(object)
      @cucumber_table.rows_hash.each_key do |key|
        mortadella[key] = cucumberator.value_for(key)
      end
      mortadella.table
    end

    private

    # Provides the Cucumberator class to use for the given object.
    def cucumberator_class(object)
      cucumberator_class_name(object).constantize
    rescue NameError
      Cucumberator
    end

    # Provides the name of the Cucumberator subclass for the given object
    def cucumberator_class_name(object)
      "#{object.class.name}Cucumberator"
    end

    # Provides a Cucumberator instance for the given ActiveRecord object
    def cucumberator_for(object)
      cucumberator_class(object).new(object, @context)
    end
  end
end
