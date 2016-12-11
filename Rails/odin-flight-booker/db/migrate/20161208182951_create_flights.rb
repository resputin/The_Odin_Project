class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.integer :origin_id,       null: false
      t.integer :destination_id,  null: false
      t.datetime :takeoff,        null: false
      t.integer :duration,        null: false

      t.timestamps
    end
  end
end
