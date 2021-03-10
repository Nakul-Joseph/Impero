module Weather
  class Forecast
    attr_reader :postcode, :cold, :hot

    def initialize(postcode)
      @postcode = postcode
    end

    def today
      response = WeatherApi.new(postcode).call
      validate_response(response)
      result_hash(response)
    end

    private

    def validate_response(response)
      raise StandardError.new(response['error']['message']) if error?(response)
      country = response['location']['country']
      raise StandardError.new('Please enter a valid UK postcode.') if country != 'UK'
    end

    def error?(response)
      response.has_key?('error')
    end

    def result_hash(response)
      max_temp_c = response['forecast']['forecastday'][0]['day']['maxtemp_c']

      {
        max_temp_c: max_temp_c,
        today: weather_today(max_temp_c)
      }
    end

    def weather_today(max_temp_c)
      case
      when max_temp_c < cold
        'Cold'
      when (max_temp_c >= cold) && (max_temp_c < hot)
        'Warm'
      when max_temp_c >= hot
        'Hot'
      end
    end

    def cold
      raise StandardError.new('Cold temperature not defined.') if Temperature.cold.nil?
      @cold ||= Temperature.cold.value
    end

    def hot
      raise StandardError.new('Hot temperature not defined.') if Temperature.hot.nil?
      @hot ||= Temperature.hot.value
    end
  end
end
