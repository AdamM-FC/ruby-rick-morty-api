class EpisodeSerializer < ActiveModel::Serializer
  attributes :id, :name, :episode, :air_date, :url, :characters

  def characters
    episode = Episode.find(object.id)
    episode.characters.map do |character|
      "#{HOST}/characters/#{character.id}"
    end
  end
end
