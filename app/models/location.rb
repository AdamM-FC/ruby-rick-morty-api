class Location < ApplicationRecord
  has_many :residents, class_name: :Character, foreign_key: :location_id
  has_many :origin, class_name: :Character, foreign_key: :origin_id
  
  validates_presence_of :name
  validates_presence_of :dimension
  validates_presence_of :location_type
  validates_presence_of :url

  def as_json(_options = {})
    json = super()
    json['residents'] = create_character_list
    json
  end

  private

  def create_character_list
    residents.map do |character|
      "#{HOST}/characters/#{character.id}"
    end
  end
end
