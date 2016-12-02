class EventsController < ApplicationController

  def new
    if session[:user_id] == nil
      flash[:error] = "You must be logged in"
      redirect_to login_path
    else
      @user = User.find_by(id: session[:user_id])
      @event = @user.events.build
    end
  end

  def create
    @user = User.find_by(id: session[:user_id])
    @event = @user.events.build(event_params)
    if @event.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def index
    @events = Event.all
    @upcoming_events = Event.upcoming
    @past_events = Event.past
  end

  private

  def event_params
    params.require(:event).permit(:location, :title, :description, :date)
  end
end