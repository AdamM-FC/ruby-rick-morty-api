class Character < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :status
    validates_presence_of :species
    validates_presence_of :character_type
    validates_presence_of :gender
    validates_presence_of :image
end