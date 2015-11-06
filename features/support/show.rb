class Show < ActiveRecord::Base
  belongs_to :genre
  has_one :director
  has_many :episodes
  has_many :subscriptions
end
