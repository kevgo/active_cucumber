# frozen_string_literal: true

class ShowCucumberator < ActiveCucumber::Cucumberator
  def value_for_director()
    director&.name()
  end

  def value_for_genre()
    genre.name()
  end
end
