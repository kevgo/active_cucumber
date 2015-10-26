require 'active_cucumber/cucumparer'
require 'active_cucumber/cucumberator'
require 'active_cucumber/active_record_builder'
require 'active_cucumber/creator'

# The main namespace for this gem
module ActiveCucumber

  # Creates entries of the given ActiveRecord class
  # specified by the given horizontal Cucumber table
  def self.create_many activerecord_class, cucumber_table, context: {}
    builder = ActiveRecordBuilder.new activerecord_class, context
    builder.create_many ActiveCucumber.horizontal_table(cucumber_table)
  end


  # Creates an entry of the given ActiveRecord class
  # specified by the given vertical Cucumber table
  def self.create_one activerecord_class, cucumber_table, context: {}
    builder = ActiveRecordBuilder.new activerecord_class, context
    builder.create_record ActiveCucumber.vertical_table(cucumber_table)
  end


  # Verifies that the database table for the given ActiveRecord class
  # matches the given horizontal Cucumber table.
  #
  # Sorts records by creation date.
  def self.diff_all! clazz, cucumber_table
    cucumparer = Cucumparer.new clazz, cucumber_table
    cucumber_table.diff! cucumparer.to_horizontal_table
  end


  # Verifies that the given object matches the given vertical Cucumber table
  def self.diff_one! object, cucumber_table
    cucumparer = Cucumparer.new object.class, cucumber_table
    cucumber_table.diff! cucumparer.to_vertical_table(object)
  end


  # Returns the given horizontal Cucumber table in standardized format
  def self.horizontal_table table
    table.hashes
  end


  # Returns the given vertical Cucumber table in standardized format
  def self.vertical_table table
    table.rows_hash
  end

end
