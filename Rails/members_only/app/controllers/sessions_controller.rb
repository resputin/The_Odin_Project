class SessionsController < ApplicationController

  def new
    @session = params[:session]
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user and @user.authenticate(params[:session][:password])
      log_in @user
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def destroy
    sign_out @user
  end
end