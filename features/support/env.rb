require 'active_record'
require 'sqlite3'
require 'mortadella'
require 'active_cucumber'


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
    t.belongs_to :show, index: true
    t.string :name
    t.integer :year
    t.datetime 'created_at'
  end
end

Before do
  Show.delete_all
  Episode.delete_all
end
