class StaticPagesController < ApplicationController
  def home
    @user = params[:user]
  end
end
