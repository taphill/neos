require_relative 'parse'

class NearEarthObjects
  def self.find_neos_by_date(date)
    {
      astroid_list: formatted_asteroid_data_on(date),
      biggest_astroid: largest_astroid_diameter_on(date),
      total_number_of_astroids: total_number_of_astroids_on(date)
    }
  end

  def self.neos_data_on(date)
    Parse.all_data_on(date)[:near_earth_objects][:"#{date}"]
  end

  def self.largest_astroid_diameter_on(date)
    neos_data_on(date).map do |astroid|
      astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    end.max { |a,b| a<=> b}
  end

  def self.total_number_of_astroids_on(date)
    neos_data_on(date).count
  end

  def self.formatted_asteroid_data_on(date)
    neos_data_on(date).map do |astroid|
      {
        name: astroid[:name],
        diameter: "#{astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
        miss_distance: "#{astroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
      }
    end
  end
end
