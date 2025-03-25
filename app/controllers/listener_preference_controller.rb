class ListenerPreferenceController < ApplicationController
  def index
    @listener_preferences = ListenerPreference.all
  end

  def show
    @listener_preference = ListenerPreference.find(params[:user_id])
  end
end
