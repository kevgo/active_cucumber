# frozen_string_literal: true

class Genre < ActiveRecord::Base
  has_many :shows
end
