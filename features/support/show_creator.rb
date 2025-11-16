# frozen_string_literal: true

class ShowCreator < ActiveCucumber::Creator
  def value_for_director(director_name)
    return(nil) if director_name.blank?

    Director.find_by(name: director_name) || FactoryBot.create(:director, name: director_name)
  end
end
