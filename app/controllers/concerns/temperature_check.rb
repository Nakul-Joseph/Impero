class TemperatureCheck
  attr_reader :maxtemp, :hot, :cold

  def initialize(api_response,hot,cold)
    @maxtemp = api_response[1]
    @hot = hot
    @cold = cold
  end

  def today
    case
    when maxtemp < cold
      'Cold'
    when (maxtemp >= cold) && (maxtemp < hot)
      'Warm'
    when maxtemp >= hot
      "Hot"
    end
  end
end
