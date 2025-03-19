# frozen_string_literal: true

class Subscription < ActiveRecord::Base
  belongs_to :show
end
