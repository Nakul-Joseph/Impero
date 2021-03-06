class ForecastsController < ApplicationController
  def index
    @hot = Temperature.find_by(name: :hot)
    @cold = Temperature.find_by(name: :cold)
  end
end
