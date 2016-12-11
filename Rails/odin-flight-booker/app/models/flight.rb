class Flight < ApplicationRecord
  belongs_to :destination, :class_name => "Airport"
  belongs_to :origin, :class_name => "Airport"
  has_many :bookings
  has_many :passengers, through: :bookings

  def takeoff_date_formatted
    takeoff_date.strftime("%m/%d/%Y")
  end

  def self.get_takeoff_dates
    takeoff_dates = Flight.find_by_sql("select distinct takeoff_date as takeoff_date from flights where takeoff is not null order by takeoff desc")
  end 

  def self.search_flights(params)
    if params[:flight] != nil
      Flight.where(:origin_id => params[:flight][:origin_id], :destination_id => params[:flight][:destination_id],
                   :takeoff_date => params[:flight][:takeoff_date])
    end
  end
end
