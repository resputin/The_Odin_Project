class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html
      format.json { render :json => @kittens }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      flash[:success] = "You did it bitch!"
      redirect_to kittens_path
    else
      render 'new'
    end
  end

  def show
    @kitten = Kitten.find_by(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @kitten }
    end
  end

  def edit
    @kitten = Kitten.find_by(params[:id])
  end

  def update
    @kitten = Kitten.find_by(params[:id])

    if @kitten.update_attributes(kitten_params)
      flash[:success] = "You did it bitch!"
      redirect_to kitten_path
    else
      render 'edit'
    end
  end

  def destroy
    Kitten.find_by(params[:id]).destroy
    flash[:success] = "You did it bitch!"
    redirect_to kittens_path
  end
  

  private

  def kitten_params
    params.require(:kitten).permit(:age, :name, :cuteness, :softness)
  end


end