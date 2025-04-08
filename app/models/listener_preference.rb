class ListenerPreference < ApplicationRecord
  def self.filter_genre(filter)
    where("top_genre = ?", "#{filter}")
  end
end
