class Show < ActiveRecord::Base
  has_many :episodes, inverse_of: :show
end
