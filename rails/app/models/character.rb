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
end
