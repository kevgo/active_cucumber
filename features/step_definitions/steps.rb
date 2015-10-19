Given(/^the TV episode:$/) do |table|
  data = table.rows_hash
  show = Show.find_or_create_by name: data['SHOW']
  @episode = show.episodes.create name: data['NAME'], year: data['YEAR']
end


Given(/^the TV episodes:$/) do |table|
  table.map_headers! { |header| header.downcase.to_sym }
  table.hashes.each do |row|
    show = Show.find_or_create_by name: row[:show]
    show.episodes.create name: row[:name], year: row[:year]
  end
end



# rubocop:disable Lint/UnusedBlockArgument
Then(/^running "([^"]+)" with this table:$/) do |code, table|
  begin
    @exception = false
    @result = eval code
  rescue StandardError => e
    @exception = true
    @error_message = e.message
  end
end
# rubocop:enable Lint/UnusedBlockArgument


Then(/^the test passes$/) do
  p @error_message if @expectation == true
  expect(@exception).to be false
end


Then(/^the test fails$/) do
  expect(@exception).to be true
end


Then(/^Cucumparer prints the error message "([^"]*)"$/) do |expected_error|
  expect(@error_message).to match expected_error
end
