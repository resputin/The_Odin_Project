class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(name: params[:session][:name])
    if @user
      session[:user_id] = @user.id
      redirect_to @user
    end
  end

  def destroy
    session = nil
    redirect_to login_path
  end

end