class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :country_name
      t.float :lat
      t.float :lng
      t.string :name
      t.integer :population

      t.timestamps null: false
    end
  end
end
