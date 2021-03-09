class TemperaturesController < ApplicationController
  def new
    @temp = Temperature.new
  end

  def create
    @temp = Temperature.find_or_create_by(temp_type: create_params[:temp_type])

    if @temp.update(value: create_params[:value])
      redirect_to :root
    else
      render :new
    end
  end

  private

  def create_params
    params.require(:temperature).permit(:temp_type,:value)
  end
end
