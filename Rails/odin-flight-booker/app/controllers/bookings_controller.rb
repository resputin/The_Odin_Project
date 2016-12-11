class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @passengers = params[:passengers].to_i
    @passengers.times {@booking.passengers.build}
    @flight_id = params[:flight_id].to_i
  end

  def create
    @booking = Booking.create(flight_id: params[:booking][:flight_id])
    passenger_params = params[:booking][:passengers_attributes]
    passenger_params.each do |passenger_index|
      @booking.passengers.create(name: passenger_params[passenger_index][:name],
                             email: passenger_params[passenger_index][:email])
    end
    if @booking.save
      redirect_to @booking
    else
      debugger
      render 'new'
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, :id, passengers_attributes:[:id, :name, :email])
  end
end