# frozen_string_literal: true

Given(/^the (\w+):$/) do |class_name, table|
  singular = class_name.singularize
  clazz = singular.humanize.constantize
  created_data = if class_name == singular
                   ActiveCucumber.create_one clazz, table
                 else
                   ActiveCucumber.create_many clazz, table
                 end
  instance_variable_set "@created_#{class_name}", created_data
end

When(/^running "([^"]+)" with this table:$/) do |code, table|
  @previous_table = table
  begin
    @error_happened = false
    @result = eval code
  rescue StandardError => e
    @error_happened = true
    @error_message = e.message
    @exception = e
  end
end

Then(/^"(.*?)" does not have a director$/) do |show_name|
  expect(Show.find_by(name: show_name).director).to be nil
end

Then(/^it returns the hash$/) do |hash_string|
  expect(@result).to match eval hash_string
end

Then(/^the database contains no (episodes|shows)$/) do |class_name|
  expect(class_name.classify.constantize).to have(0).records
end

Then(/^the database contains the given episode$/) do
  expect(Episode).to have(1).instance
  ActiveCucumber.diff_one! Episode.first, @previous_table
end

Then(/^the database contains the given episodes$/) do
  ActiveCucumber.diff_all! Episode, @previous_table
end

Then(/^the database contains the given shows$/) do
  ActiveCucumber.diff_all! Show, @previous_table
end

Then(/^the database contains the (\w+):$/) do |class_name, table|
  ActiveCucumber.diff_all! class_name.humanize.singularize.constantize, table
end

Then(/^the database contains the shows? (.+)$/) do |show_names|
  expect(Show.all.map(&:name)).to match Kappamaki.from_sentence show_names
end

Then(/^the test (passes|fails)$/) do |expected_result|
  @error_checked = true
  if expected_result == 'passes' && @error_happened
    puts "\n#{@error_message}"
    puts ''
    @exception.backtrace.take(5).each { |trace| puts "in #{trace}" }
  end
  expect(@error_happened).to be expected_result != 'passes'
end

Then(/^Cucumparer prints the error message "([^"]*)"$/) do |expected_error|
  expect(@error_message).to match expected_error
end
