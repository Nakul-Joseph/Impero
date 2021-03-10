module Weather
  class WeatherApi
    attr_reader :postcode

    def initialize(postcode)
      @postcode = postcode
    end

    def call
      raise StandardError.new('Invalid postcode provided.') if postcode.empty?

      response = HTTParty.get(forecast_url)
      JSON.parse(response.body)
    end

    private

    def forecast_url
      base_url + api_key + "&q=#{postcode}&days=1&aqi=no&alerts=no"
    end

    def base_url
      'https://api.weatherapi.com/v1/forecast.json?'
    end

    def api_key
      "key=#{ WEATHER_API['key'] }"
    end
  end
end
