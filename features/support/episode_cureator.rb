class EpisodeCureator < ActiveCucumber::Cureator

  def value_for_show show_name
    Show.find_by(name: show_name) || FactoryGirl.create(:show, name: show_name)
  end

end
