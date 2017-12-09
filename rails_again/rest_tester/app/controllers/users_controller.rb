class UsersController < ApplicationController
  def index
    @name = "I am index"
  end

  def show
    @name = "I am show"
  end

  def new
    @name = "I am new"
  end

  def create
  end

  def edit
    @name = "I am edit"
  end

end