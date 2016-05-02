class AddMissingFieldsToPlace < ActiveRecord::Migration
  def change
  	add_column :places, :geoname_id, :integer
  	add_column :places, :elevation, :integer
  end
end
