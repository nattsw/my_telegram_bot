class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
    end
  end

  def down
    drop_table :locations
  end
end
