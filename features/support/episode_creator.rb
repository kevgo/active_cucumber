class EpisodeCreator < ActiveCucumber::Creator
  def value_for_show(show_name)
    Show.find_by(name: show_name) || FactoryBot.create(:show, name: show_name, genre: @genre)
  end

  def value_for_genre(genre_name)
    @genre = Genre.find_by(name: genre_name) || FactoryBot.create(:genre, name: genre_name)
    delete :genre
  end
end
