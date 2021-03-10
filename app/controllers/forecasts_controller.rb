# frozen_string_literal: true

class ForecastsController < ApplicationController
  def index
    @hot = Temperature.hot
    @cold = Temperature.cold
  end

  def search
    forecast = Weather::Forecast.new(search_params[:postcode])
    @response = forecast.today
  rescue StandardError => e
    flash.now[:error] = e.message
  end

  private

  def search_params
    params.require(:search).permit(:postcode)
  end
end
