require 'active_record'
require 'sqlite3'
require 'mortadella'
require 'active_cucumber'
require 'factory_girl'
require 'faker'
require 'kappamaki'
require 'rspec/collection_matchers'


ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)


ActiveRecord::Schema.define do
  create_table :shows, force: true do |t|
    t.string :name
    t.datetime 'created_at'
  end

  create_table :episodes, force: true do |t|
    t.belongs_to :show
    t.string :name
    t.integer :year
    t.datetime 'created_at'
  end
end


FactoryGirl.define do
  factory :show do
    name { Faker::Book.title }
  end

  factory :episode do
    name { Faker::Book.title }
    year { 1960 + rand(40) }
    show
  end
end


Before do
  Show.delete_all
  Episode.delete_all
  @error_checked = false
end

After do
  if @error_happened && !@error_checked
    puts "\n#{@error_message}"
    puts ''
    @exception.backtrace.take(5).each { |trace| puts "in #{trace}" }
    expect(@error_happened).to be false
  end
end
