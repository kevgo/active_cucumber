# frozen_string_literal: true

module ActiveCucumber
  # Provides Mortadella instances of the given database content for comparison
  class Cucumparer
    # @param database_content [Class, ActiveRecord::Relation, Array] The ActiveRecord class, relation, or array of records
    # @param cucumber_table [Cucumber::Core::Ast::DataTable] The Cucumber table to compare against
    # @param context [Hash] Optional context values passed to Cucumberator instances
    def initialize(database_content, cucumber_table, context)
      @database_content = database_content
      @cucumber_table = cucumber_table
      @context = context
    end

    # Returns all entries in the database as a horizontal Mortadella table
    #
    # @return [Mortadella::Horizontal] A Mortadella table representing all database records
    def to_horizontal_table
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
    #
    # @param object [ActiveRecord::Base] The ActiveRecord instance to convert
    # @return [Mortadella::Vertical] A Mortadella table representing the record
    def to_vertical_table(object)
      mortadella = Mortadella::Vertical.new
      cucumberator = cucumberator_for object
      @cucumber_table.rows_hash.each_key do |key|
        mortadella[key] = cucumberator.value_for key
      end
      mortadella.table
    end

    private

    # Returns the Cucumberator subclass to be used by this Cucumparer instance
    def cucumberator_class(object)
      cucumberator_class_name(object).constantize
    rescue NameError
      Cucumberator
    end

    # Returns the name of the Cucumberator subclass to be used by this Cucumparer instance.
    def cucumberator_class_name(object)
      "#{object.class.name}Cucumberator"
    end

    # Returns the Cucumberator object for the given ActiveRecord instance
    def cucumberator_for(object)
      cucumberator_class(object).new object, @context
    end
  end
end
