class EpisodeCreator < ActiveCucumber::Creator

  def value_for_show show_name
    return nil if show_name.blank?
    Show.find_by(name: show_name) || FactoryGirl.create(:show, name: show_name, genre: @genre)
  end

  def value_for_genre genre_name
    @genre = Genre.find_by(name: genre_name) || FactoryGirl.create(:genre, name: genre_name)
    delete :genre
  end

end
