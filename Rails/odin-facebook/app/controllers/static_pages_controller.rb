class StaticPagesController < ApplicationController
  def home
    if current_user
      redirect_to current_user
    end
  end
end