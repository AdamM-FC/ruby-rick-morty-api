class Episode < ApplicationRecord
  has_and_belongs_to_many :characters

  validates_presence_of :name
  validates_presence_of :air_date
  validates_presence_of :episode
  validates_presence_of :url

  def as_json(_options = {})
    super(include: :characters)
  end
end
