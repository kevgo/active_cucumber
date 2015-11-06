class ShowCucumberator < ActiveCucumber::Cucumberator

  def value_for_director
    director ? director.name : ''
  end

  def value_for_genre
    genre.name
  end

end
