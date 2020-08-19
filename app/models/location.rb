class Location < ApplicationRecord
  has_many :residents, class_name: :Character, foreign_key: :location_id
  has_many :born_characters, class_name: :Character, foreign_key: :origin_id
  
  def as_json(_options = {})
    json = super()
    json['residents'] = create_character_list
    json
  end

  private

  def create_character_list
    residents.map do |character|
      "http://localhost:3000/characters/#{character.id}"
    end
  end
end
