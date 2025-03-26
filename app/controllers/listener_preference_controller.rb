class ListenerPreferenceController < ApplicationController
  def index
    @listener_preferences = ListenerPreference.all
  end

  def show
    @listener_preference = ListenerPreference.find(params[:user_id])
  end

  def top_genres
    @top_genres = ListenerPreference.group("top_genre").order("COUNT(top_genre) DESC").count
  end
end
