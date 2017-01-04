class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      redirect_to kittens_path
    else
      render 'new'
    end
  end

  def show
    @kitten = Kitten.find_by(params[:id])
  end

  def edit
    @kitten = Kitten.find_by(params[:id])
  end

  def update
    @kitten = Kitten.find_by(params[:id])

    if @kitten.update_attributes(kitten_params)
      redirect_to kitten_path
    else
      render 'edit'
    end
  end

  def destroy
    Kitten.find_by(params[:id]).destroy
  end
  

  private

  def kitten_params
    params.require(:kitten).permit(:age, :name, :cuteness, :softness)
  end


end