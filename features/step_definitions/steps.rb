Given(/^the TV episode:$/) do |table|
  data = ActiveCucumber.vertical_table table
  show = Show.find_or_create_by name: data['SHOW']
  @episode = show.episodes.create name: data['NAME'], year: data['YEAR']
end


Given(/^the TV episodes:$/) do |table|
  ActiveCucumber.horizontal_table(table).each do |row|
    show = Show.find_or_create_by name: row['SHOW']
    show.episodes.create name: row['NAME'], year: row['YEAR']
  end
end



Then(/^running "([^"]+)" with this table:$/) do |code, table|
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


Then(/^the database contains the given episode$/) do
  expect(Episode).to have(1).instance
  ActiveCucumber.diff_one! Episode.first, @previous_table
end


Then(/^the database contains the given episodes$/) do
  ActiveCucumber.diff_all! Episode, @previous_table
end


Then(/^the database contains the shows? (.+)$/) do |show_names|
  expect(Show.all.map(&:name)).to match Kappamaki.from_sentence show_names
end


Then(/^the test (passes|fails)$/) do |expected_result|
  @error_checked = true
  if expected_result == 'passes' && @error_happened
    p @error_message
    p @exception
  end
  expect(@error_happened).to be expected_result != 'passes'
end


Then(/^Cucumparer prints the error message "([^"]*)"$/) do |expected_error|
  expect(@error_message).to match expected_error
end
