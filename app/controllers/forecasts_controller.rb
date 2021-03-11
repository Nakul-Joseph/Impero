# frozen_string_literal: true

class ForecastsController < ApplicationController
  def index
    @hot, @cold = hot_and_cold
  end

  def search
    forecast = Weather::Forecast.new(search_params[:postcode])
    @response = forecast.today
    @hot, @cold = hot_and_cold
  rescue StandardError => e
    flash.now[:error] = e.message
  end

  private

  def search_params
    params.require(:search).permit(:postcode)
  end

  def hot_and_cold
    [Temperature.hot,Temperature.cold]
  end
end
