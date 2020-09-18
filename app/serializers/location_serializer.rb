class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :dimension, :url, :residents

  def residents
    location = Location.find(object.id)
    location.residents.map do |character|
      "#{HOST}/characters/#{character.id}"
    end
  end

  def type
    "#{object.location_type}"
  end
end
