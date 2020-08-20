class Character < ApplicationRecord
  has_and_belongs_to_many :episodes

  validates_presence_of :name
  validates_presence_of :status
  validates_presence_of :species
  validates_presence_of :character_type
  validates_presence_of :gender
  validates_presence_of :image

  def as_json(_options = {})
    json = super()
    json['episode'] = create_episode_list
    json
  end

  private

  def create_episode_list
    episodes.map do |episode|
      "http://localhost:3000/episodes/#{episode.id}"
    end
  end
end
