OpenWeather::Client.configure do |config|
    # 903654b50c59fdb3bdf02a2def84b2e5
    config.api_key = Rails.application.credentials[:open_weather][:api_key]
end