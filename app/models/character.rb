class Character < ApplicationRecord
  has_and_belongs_to_many :episodes

  belongs_to :location, class_name: :Location, foreign_key: :location_id
  belongs_to :origin, class_name: :Location, foreign_key: :origin_id

  validates_presence_of :name
  validates_presence_of :status
  validates_presence_of :species
  validates_presence_of :character_type
  validates_presence_of :gender
  validates_presence_of :image

  def as_json(_options = {})
    json = super(except: %i[location_id origin_id])
    json['episode'] = create_episode_list
    json['location'] = location_json(location)
    json['origin'] = location_json(origin)
    json
  end

  private

  def location_json(location)
    {
      name: location.name,
      url: "www.google.com/#{location.id}"
    }
  end

  def create_episode_list
    episodes.map do |episode|
      "http://localhost:3000/episodes/#{episode.id}"
    end
  end
end
