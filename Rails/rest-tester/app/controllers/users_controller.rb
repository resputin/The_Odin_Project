class UsersController < ApplicationController
  def index
    @name = "I am the index method"
  end

  def new
    @name = "I am new"
  end

  def edit
    @name = "I am edit"
  end

  def show
    @name = "I am show"
  end

  def create
    @name = "I am create"
  end
end
