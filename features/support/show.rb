class Show < ActiveRecord::Base
  belongs_to :genre
  has_many :episodes
end
