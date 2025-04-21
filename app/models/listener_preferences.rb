class ListenerPreferences < ApplicationRecord
  def self.filter_genre(filter)
    where("top_genre = ?", "#{filter}")
  end

  def self.search(id)
    where("user_id = ?", "#{id}")
  end
end
