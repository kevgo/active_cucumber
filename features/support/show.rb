# frozen_string_literal: true

class Show < ActiveRecord::Base
  belongs_to :genre
  belongs_to :director
  has_many :episodes
  has_many :subscriptions
end
