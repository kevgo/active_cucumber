class EpisodeCureator < ActiveCucumber::Cureator

  def value_for_show show_name
    Show.find_by(name: show_name) || FactoryGirl.create(:show, name: show_name, genre: @genre)
  end

  def value_for_genre genre_name
    @genre = Genre.find_by(name: genre_name) || FactoryGirl.create(:genre, name: genre_name)
    self.delete :genre
  end

end
