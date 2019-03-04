# config/initializers/open-weather-api.rb

# Note that 'config' is an instance of `OpenWeatherAPI::API` (just name it as you like).
OpenWeatherAPI.configure do |config|
  # API key
  config.api_key = "2a13ea30a4882ef3c4f6ca3c0dda3dcc"

  # Optionals
  config.default_language = 'es'     # 'en' by default
  config.default_country_code = 'es' # nil by default (ISO 3166-1 alfa2)
  config.default_units = 'metric'    # 'metric' by default
end