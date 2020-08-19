class AddLocationsToCharactersTable < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :location_id, :integer
    add_column :characters, :origin_id, :integer
  end
end
