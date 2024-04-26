# app/controllers/forecasts_controller.rb
class ForecastsController < ApplicationController
  def index
    city = params[:city]
    zip = params[:zip]

    cached_forecast = Forecast.find_by(zip: zip)

    if cached_forecast && cached_forecast.expires_at > Time.now
      @forecast = JSON.parse(cached_forecast.forecast_data)['main']
      @cached = true
    else
      forecast_data = get_data(city)
      return unless forecast_data

      @forecast = forecast_data['main']
      Forecast.create(zip: zip, forecast_data: forecast_data.to_json, expires_at: Time.now + 30.minutes)
      @cached = false
    end
  end

  private

  def get_data(city)
    begin
      client = OpenWeather::Client.new
      client.current_weather(city: city, units: 'imperial')
    rescue Faraday::ResourceNotFound => e
      puts "Error: #{e.message}"
    rescue StandardError => e
      puts "An unexpected error occurred: #{e.message}"
    end
  end
end
