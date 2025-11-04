# frozen_string_literal: true

require "active_record"
require "active_cucumber/cucumparer"
require "active_cucumber/cucumberator"
require "active_cucumber/active_record_builder"
require "active_cucumber/creator"

# The main namespace for this gem
module ActiveCucumber
  # Returns the attributes to create an instance of the given ActiveRecord class
  # that matches the given vertical Cucumber table
  def self.attributes_for(activerecord_class, cucumber_table, context: {})
    validate_activerecord_class!(activerecord_class)
    validate_context!(context)
    builder = ActiveRecordBuilder.new activerecord_class, context
    builder.attributes_for ActiveCucumber.vertical_table(cucumber_table)
  end

  # Creates entries of the given ActiveRecord class
  # specified by the given horizontal Cucumber table
  def self.create_many(activerecord_class, cucumber_table, context: {})
    validate_activerecord_class!(activerecord_class)
    validate_context!(context)
    builder = ActiveRecordBuilder.new activerecord_class, context
    builder.create_many ActiveCucumber.horizontal_table(cucumber_table)
  end

  # Creates an entry of the given ActiveRecord class
  # specified by the given vertical Cucumber table
  def self.create_one(activerecord_class, cucumber_table, context: {})
    validate_activerecord_class!(activerecord_class)
    validate_context!(context)
    builder = ActiveRecordBuilder.new activerecord_class, context
    builder.create_record ActiveCucumber.vertical_table(cucumber_table)
  end

  # Verifies that the database table for the given ActiveRecord class
  # matches the given horizontal Cucumber table.
  #
  # Sorts records by creation date.
  def self.diff_all!(clazz, cucumber_table, context: {})
    validate_activerecord_class_or_collection!(clazz)
    validate_context!(context)
    cucumparer = Cucumparer.new clazz, cucumber_table, context
    cucumber_table.diff! cucumparer.to_horizontal_table
  end

  # Verifies that the given object matches the given vertical Cucumber table
  def self.diff_one!(object, cucumber_table, context: {})
    validate_activerecord_instance!(object)
    validate_context!(context)
    cucumparer = Cucumparer.new object.class, cucumber_table, context
    cucumber_table.diff! cucumparer.to_vertical_table(object)
  end

  # Returns the given horizontal Cucumber table in standardized format
  def self.horizontal_table(table)
    table.hashes
  end

  # Returns the given vertical Cucumber table in standardized format
  def self.vertical_table(table)
    table.rows_hash
  end

  # @api private
  def self.validate_activerecord_class!(klass)
    return if klass.is_a?(Class) && klass < ActiveRecord::Base

    raise TypeError, "Expected an ActiveRecord class, got #{klass.inspect}"
  end

  # @api private
  def self.validate_activerecord_class_or_collection!(value)
    # Allow ActiveRecord class, array of instances, or ActiveRecord relation/association
    return if value.is_a?(Class) && value < ActiveRecord::Base
    return if value.is_a?(Array) || value.respond_to?(:all)

    raise TypeError, "Expected an ActiveRecord class or collection, got #{value.class}"
  end

  # @api private
  def self.validate_activerecord_instance!(object)
    return if object.is_a?(ActiveRecord::Base)

    raise TypeError, "Expected an ActiveRecord instance, got #{object.class}"
  end

  # @api private
  def self.validate_context!(context)
    return if context.is_a?(Hash)

    raise TypeError, "Expected context to be a Hash, got #{context.class}"
  end
end
