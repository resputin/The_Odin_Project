class AddTakeoffDateToFlights < ActiveRecord::Migration[5.0]
  def change
    add_column :flights, :takeoff_date, :date
  end
end
