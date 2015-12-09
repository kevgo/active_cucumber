class ShowCucumberator < ActiveCucumber::Cucumberator

  def value_for_director
    director.try :name
  end

  def value_for_genre
    genre.name
  end

end
