class EpisodeCucumberator < ActiveCucumber::Cucumberator

  def value_for_show
    show.name
  end

end
