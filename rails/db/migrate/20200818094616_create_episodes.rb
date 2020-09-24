class CreateEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_table :episodes do |t|
      t.string :name
      t.time :air_date
      t.string :episode
      t.string :url
      t.time :created, default: Time.now
    end
  end
end
