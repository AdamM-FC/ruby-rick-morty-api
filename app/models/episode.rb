class Episode < ApplicationRecord
  has_and_belongs_to_many :characters

  validates_presence_of :name
  validates_presence_of :air_date
  validates_presence_of :episode
  validates_presence_of :url

  def as_json(_options = {})
    json = super()
    json['character'] = create_character_list
    json
  end

  private

  def create_character_list
    characters.map do |character|
      "http://localhost:3000/characters/#{character.id}"
    end
  end
end
