# frozen_string_literal: true

class TemperaturesController < ApplicationController
  def new
    @temp = Temperature.new
  end

  def create
    @temp = Temperature.find_or_create_by(temp_type: create_params[:temp_type])
    @temp.update!(value: create_params[:value])
    flash[:success] = 'Temperature definition added successfully.'
  rescue StandardError => e
    flash[:error] = e.message
  ensure
    redirect_to :root
  end

  private

  def create_params
    params.require(:temperature).permit(:temp_type, :value)
  end
end
