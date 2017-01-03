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
  

  private

  def kitten_params
    params.require(:kitten).permit(:age, :name, :cuteness, :softness)
  end


end