require 'json'
require './env_helper'
require_relative 'faraday_wrapper'

class Asteroid
  def self.all_data_on(date)
    conn = FaradayWrapper.connection(
      url: 'https://api.nasa.gov',
      params: { start_date: date, api_key: ENV['nasa_api_key']}
    )

    JSON.parse(
      conn.get('/neo/rest/v1/feed').body,
      symbolize_names: true
    )
  end
end
