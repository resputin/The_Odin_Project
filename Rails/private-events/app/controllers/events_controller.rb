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
  end

  def index
  end

  private

  def event_params
    params.require(:event).permit(:location)
  end
end