class ForecastsController < ApplicationController
  def index
    @hot = Temperature.find_by(temp_type: :hot)
    @cold = Temperature.find_by(temp_type: :cold)
  end
end
