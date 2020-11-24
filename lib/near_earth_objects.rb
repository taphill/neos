require 'faraday'
require 'json'
require './env_helper'
require_relative 'faraday_wrapper'
require_relative 'asteroid'

class NearEarthObjects
  def self.find_neos_by_date(date)
    largest_astroid_diameter = neos_data_on(date).map do |astroid|
      astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    end.max { |a,b| a<=> b}

    total_number_of_astroids = neos_data_on(date).count
    formatted_asteroid_data = neos_data_on(date).map do |astroid|
      {
        name: astroid[:name],
        diameter: "#{astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
        miss_distance: "#{astroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
      }
    end

    {
      astroid_list: formatted_asteroid_data,
      biggest_astroid: largest_astroid_diameter,
      total_number_of_astroids: total_number_of_astroids
    }
  end

  def self.neos_data_on(date)
    Asteroid.all_data_on(date)[:near_earth_objects][:"#{date}"]
  end
end
