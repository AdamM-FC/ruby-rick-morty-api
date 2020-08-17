class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :status
      t.string :species
      t.string :character_type
      t.string :gender
      t.string :image
      t.time :created, default: Time.now
    end
  end
end