class ListenerPreferencesController < ApplicationController
  before_action :set_user, only: %i[ show destroy ]

  def index
    @listener_preferences = ListenerPreferences.all
    if params[:genre].blank?
      @listener_preferences = ListenerPreferences.all
    elsif params[:genre]
      @listener_preferences = ListenerPreferences.filter_genre(params[:genre])
    end

    @genre_list = ListenerPreferences.distinct.pluck(:top_genre)
  end

  def show
  end

  def top_lists
    @top_genres = ListenerPreferences.group("top_genre").order("COUNT(top_genre) DESC").count
    @top_artists = ListenerPreferences.group("most_played_artist").order("COUNT(most_played_artist) DESC").count
    @top_countries = ListenerPreferences.group("country").order("COUNT(country) DESC").count
    @listening_time = ListenerPreferences.group("listening_time").order("COUNT(listening_time) DESC").count
    @streaming_platform = ListenerPreferences.group("streaming_platform").order("COUNT(streaming_platform) DESC").count
  end

  def create_user
    @listener_preference = ListenerPreferences.new
  end

  def create
    @listener_preference = ListenerPreferences.new(listener_preference_params)
    @listener_preference.user_id = generate_user_id()
    if @listener_preference.save
      redirect_to @listener_preference
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to listener_preferences_path
  end

  private
    def listener_preference_params
      params.expect(listener_preferences: [ :age, :country, :streaming_platform, :top_genre, :minutes_streamed_per_day,
      :number_of_songs_liked, :most_played_artist, :subscription_type, :listening_time, :discover_weekly_engagement,
      :repeat_song_rate ])
    end

    def generate_user_id
      new_user_id = ListenerPreferences.maximum(:user_id).sub(/[U]/, "")
      new_user_id = Integer(new_user_id) + 1
      new_user_id = "U" + String(new_user_id)
    end

    def set_user
      @user = ListenerPreferences.find(params[:user_id])
    end
end
