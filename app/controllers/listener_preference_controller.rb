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

  def create_user
    @listener_preference = ListenerPreference.new
  end

  def create
    @listener_preference = ListenerPreference.new(listener_preference_params)
    @listener_preference.user_id = generate_user_id()
    if @listener_preference.save
      redirect_to @listener_preference
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def listener_preference_params
      params.expect(listener_preference: [ :age, :country, :streaming_platform, :top_genre, :minutes_streamed_per_day,
      :number_of_songs_liked, :most_played_artist, :subscription_type, :listening_time, :discover_weekly_engagement,
      :repeat_song_rate ])
    end

  private
    def generate_user_id
      new_user_id = ListenerPreference.maximum(:user_id).sub(/[U]/, "")
      new_user_id = Integer(new_user_id) + 1
      new_user_id = "U" + String(new_user_id)
    end
end
