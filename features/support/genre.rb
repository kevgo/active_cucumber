class Genre < ActiveRecord::Base
  has_many :shows
end
