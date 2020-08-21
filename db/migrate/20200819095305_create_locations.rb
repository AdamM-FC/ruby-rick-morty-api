class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :location_type
      t.string :dimension
      t.string :url
      t.time :created, default: Time.now
    end
  end
end
