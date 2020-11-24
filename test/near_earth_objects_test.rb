require 'minitest/autorun'
require 'minitest/pride'
require './lib/near_earth_objects'

class NearEarthObjectsTest < Minitest::Test
  def test_a_date_returns_a_list_of_neos
    results = NearEarthObjects.find_neos_by_date('2019-03-30')

    assert_equal '(2019 GD4)', results[:astroid_list][8][:name]
  end
end
