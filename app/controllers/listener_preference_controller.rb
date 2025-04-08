class ListenerPreferenceController < ApplicationController
  def index
    @listener_preferences = ListenerPreference.all
    if params[:genre].blank?
      @listener_preferences = ListenerPreference.all
    elsif params[:genre]
      @listener_preferences = ListenerPreference.filter_genre(params[:genre])
    end

    @genre_list = ListenerPreference.distinct.pluck(:top_genre)
  end

  def user
    @user = ListenerPreference.find(params[:user_id])
  end

  def top_lists
    @top_genres = ListenerPreference.group("top_genre").order("COUNT(top_genre) DESC").count
    @top_artists = ListenerPreference.group("most_played_artist").order("COUNT(most_played_artist) DESC").count
    @top_countries = ListenerPreference.group("country").order("COUNT(country) DESC").count
    @listening_time = ListenerPreference.group("listening_time").order("COUNT(listening_time) DESC").count
    @streaming_platform = ListenerPreference.group("streaming_platform").order("COUNT(streaming_platform) DESC").count
  end
end
