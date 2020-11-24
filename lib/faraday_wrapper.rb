require 'faraday'

module FaradayWrapper
  def self.connection(url:, params:)
    Faraday.new(url: url, params: params)
  end
end
