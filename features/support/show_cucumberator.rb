class ShowCucumberator < ActiveCucumber::Cucumberator

  def value_for_genre
    genre.name
  end

end
