# frozen_string_literal: true

if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
end

require 'active_record'
require 'sqlite3'
require 'mortadella'
require 'active_cucumber'
require 'factory_bot'
require 'faker'
require 'kappamaki'
require 'rspec/collection_matchers'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table :genres, force: true do |t|
    t.string :name
    t.datetime 'created_at'
  end

  create_table :shows, force: true do |t|
    t.belongs_to :genre
    t.belongs_to :director
    t.string :name
    t.datetime 'created_at'
  end

  create_table :episodes, force: true do |t|
    t.belongs_to :show
    t.string :name
    t.integer :year
    t.datetime 'created_at'
  end

  create_table :subscriptions, force: true do |t|
    t.string :subscriber
    t.belongs_to :show
    t.datetime 'created_at'
  end

  create_table :directors, force: true do |t|
    t.string :name
    t.datetime 'created_at'
  end
end

FactoryBot.define do
  factory :genre do
    name { Faker::Book.title }
  end

  factory :show do
    name { Faker::Book.title }
    director
  end

  factory :episode do
    name { Faker::Book.title }
    year { rand(1960..1999) }
    show
  end

  factory :subscription do
    subscriber { Faker::Name.name }
    show
  end

  factory :director do
    name { Faker::Name.name }
  end
end

Before do
  Show.delete_all
  Episode.delete_all
  Subscription.delete_all
  Director.delete_all
  Genre.delete_all
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
