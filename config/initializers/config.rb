# frozen_string_literal: true

config = YAML.load_file('config/config.yml')
WEATHER_API = config['weather_api']
