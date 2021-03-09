class ForecastsController < ApplicationController
  def index
    @hot = Temperature.find_by(temp_type: :hot)
    @cold = Temperature.find_by(temp_type: :cold)
  end

  def search
    api = WeatherApi.new(search_params[:postcode])
    @response = api.call

    return if @response.empty?

    hot = Temperature.find_by(temp_type: :hot)
    cold = Temperature.find_by(temp_type: :cold)

    @today = TemperatureCheck.new(@response,hot.value,cold.value).today
  end

  private

  def search_params
    params.require(:search).permit(:postcode)
  end
end
