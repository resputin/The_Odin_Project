class FlightsController < ApplicationController
  
  def index
    @airport_options = Airport.all.map { |u| [u.code, u.id] }
    @flight_options = Flight.all.map { |u| [u.takeoff, u.id] }
    @flight = Flight.new
    @flights = Flight.search_flights(params)
    @booking = Booking.new
    @passengers = (params[:flight][:passengers]) unless params[:flight].nil?
  end

end