class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :location_type, :dimension, :url, :residents

  def residents
    location = Location.find(object.id)
    location.residents.map do |character|
      "#{HOST}/characters/#{character.id}"
    end
  end
end
