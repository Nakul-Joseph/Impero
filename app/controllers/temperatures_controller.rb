class TemperaturesController < ApplicationController
  def new
    @temp = Temperature.new
  end

  def create
    @temp = Temperature.find_or_create_by(temp_type: create_params[:temp_type])
    @temp.update(value: create_params[:value])
    flash[:error] = @temp.errors.full_messages if @temp.errors.any?
    redirect_to :root
  end

  private

  def create_params
    params.require(:temperature).permit(:temp_type,:value)
  end
end
