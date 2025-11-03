# frozen_string_literal: true

require "active_cucumber/cucumparer"
require "active_cucumber/cucumberator"
require "active_cucumber/active_record_builder"
require "active_cucumber/creator"

# The main namespace for this gem
module ActiveCucumber
  # Returns the attributes to create an instance of the given ActiveRecord class
  # that matches the given vertical Cucumber table
  #
  # @param activerecord_class [Class] The ActiveRecord class to create attributes for
  # @param cucumber_table [Cucumber::Core::Ast::DataTable] A vertical Cucumber table
  # @param context [Hash] Optional context values available as instance variables in Creator classes
  # @return [Hash] A hash of attributes ready for FactoryBot
  def self.attributes_for(activerecord_class, cucumber_table, context: {})
    builder = ActiveRecordBuilder.new activerecord_class, context
    builder.attributes_for ActiveCucumber.vertical_table(cucumber_table)
  end

  # Creates entries of the given ActiveRecord class
  # specified by the given horizontal Cucumber table
  #
  # @param activerecord_class [Class] The ActiveRecord class to create instances of
  # @param cucumber_table [Cucumber::Core::Ast::DataTable] A horizontal Cucumber table
  # @param context [Hash] Optional context values available as instance variables in Creator classes
  # @return [Array] An array of created ActiveRecord instances
  def self.create_many(activerecord_class, cucumber_table, context: {})
    builder = ActiveRecordBuilder.new activerecord_class, context
    builder.create_many ActiveCucumber.horizontal_table(cucumber_table)
  end

  # Creates an entry of the given ActiveRecord class
  # specified by the given vertical Cucumber table
  #
  # @param activerecord_class [Class] The ActiveRecord class to create an instance of
  # @param cucumber_table [Cucumber::Core::Ast::DataTable] A vertical Cucumber table
  # @param context [Hash] Optional context values available as instance variables in Creator classes
  # @return [ActiveRecord::Base] The created ActiveRecord instance
  def self.create_one(activerecord_class, cucumber_table, context: {})
    builder = ActiveRecordBuilder.new activerecord_class, context
    builder.create_record ActiveCucumber.vertical_table(cucumber_table)
  end

  # Verifies that the database table for the given ActiveRecord class
  # matches the given horizontal Cucumber table.
  #
  # Sorts records by creation date. Raises an exception if there's a mismatch.
  #
  # @param clazz [Class] The ActiveRecord class to compare
  # @param cucumber_table [Cucumber::Core::Ast::DataTable] A horizontal Cucumber table
  # @param context [Hash] Optional context values available as instance variables in Cucumberator classes
  # @raise [Cucumber::Core::Test::Result::Failed] If the database content doesn't match the table
  def self.diff_all!(clazz, cucumber_table, context: {})
    cucumparer = Cucumparer.new clazz, cucumber_table, context
    cucumber_table.diff! cucumparer.to_horizontal_table
  end

  # Verifies that the given object matches the given vertical Cucumber table
  #
  # @param object [ActiveRecord::Base] The ActiveRecord instance to compare
  # @param cucumber_table [Cucumber::Core::Ast::DataTable] A vertical Cucumber table
  # @param context [Hash] Optional context values available as instance variables in Cucumberator classes
  # @raise [Cucumber::Core::Test::Result::Failed] If the object doesn't match the table
  def self.diff_one!(object, cucumber_table, context: {})
    cucumparer = Cucumparer.new object.class, cucumber_table, context
    cucumber_table.diff! cucumparer.to_vertical_table(object)
  end

  # Returns the given horizontal Cucumber table in standardized format
  #
  # @param table [Cucumber::Core::Ast::DataTable] A Cucumber table
  # @return [Array<Hash>] An array of hashes, one per row
  def self.horizontal_table(table)
    table.hashes
  end

  # Returns the given vertical Cucumber table in standardized format
  #
  # @param table [Cucumber::Core::Ast::DataTable] A Cucumber table
  # @return [Hash] A hash mapping column names to values
  def self.vertical_table(table)
    table.rows_hash
  end
end
