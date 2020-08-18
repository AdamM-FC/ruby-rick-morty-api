class CreateCharactersEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_table :characters_episodes do |t|
      t.references :character, null: false, foreign_key: true
      t.references :episode, null: false, foreign_key: true

      t.timestamps
    end
  end
end
