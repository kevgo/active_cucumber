class Episode < ActiveRecord::Base
  belongs_to :show, required: true
end
