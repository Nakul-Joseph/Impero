class WeatherApi
  attr_reader :postcode

  def initialize(postcode)
    @postcode = postcode
  end

  def call
    response = HTTParty.get(base_url + api_key + q_postcode + days + air_quality + alerts)
    body = JSON.parse(response.body)
    result = []
    result << body['location']['country'] unless body.has_key?('error')
    result << body['forecast']['forecastday'][0]['day']['maxtemp_c'] unless body.has_key?('error')
    result
  end

  private

  def base_url
    'https://api.weatherapi.com/v1/forecast.json?'
  end

  def api_key
    'key=50a0d136f6bd49d69d6143859210603'
  end

  def q_postcode
    "&q=#{postcode}"
  end

  def days
    '&days=1'
  end

  def air_quality
    '&aqi=no'
  end

  def alerts
    '&alerts=no'
  end
end
