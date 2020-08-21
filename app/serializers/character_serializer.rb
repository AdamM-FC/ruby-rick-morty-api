class CharacterSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :species, :character_type, :gender, :image, :created, :location, :origin, :episode

  def location
    location = Location.find(object.location_id)
    location_json(location)
  end

  def origin
    origin = Location.find(object.origin_id)
    location_json(origin)
  end

  def location_json(location)
    {
      name: location.name,
      url: "#{HOST}locations/#{location.id}"
    }
  end

  def episode
    character = Character.find(object.id)
    character.episodes.map do |episode|
      "#{HOST}/episodes/#{episode.id}"
    end
  end
end