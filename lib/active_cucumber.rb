require 'active_cucumber/cucumparer'
require 'active_cucumber/cucumberator'

# The main namespace for this gem
module ActiveCucumber

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

end
