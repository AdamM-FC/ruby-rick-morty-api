class Location < ApplicationRecord
  has_many :residents, class_name: :Character, foreign_key: :location_id
  has_many :origin, class_name: :Character, foreign_key: :origin_id
  
  validates_presence_of :name
  validates_presence_of :dimension
  validates_presence_of :location_type
  validates_presence_of :url
end
