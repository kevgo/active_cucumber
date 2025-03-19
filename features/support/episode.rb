# frozen_string_literal: true

class Episode < ActiveRecord::Base
  belongs_to :show, required: true
end
