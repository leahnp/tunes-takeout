require 'test_helper'

class FoodTest < ActiveSupport::TestCase
  test "unicode business id" do
    query = {
      '123456789' => { food_id: 'fiddlehead-fine-foods-and-café-seattle' }
    }
    results = Food.find(query)

    first_result = results[0]
    key = first_result[0]
    business = first_result[1]

    assert_equal business.name, 'Fiddlehead Fine Foods & Café'
  end

  test "food returns expected array in correct format" do
    query = {
      '123456789' => { food_id: 'fiddlehead-fine-foods-and-café-seattle' }
    }
    results = Food.find(query)

    assert_equal results.length, 1

    first_result = results[0]
    key = first_result[0]
    business = first_result[1]

    assert_equal first_result[0], '123456789'
  end
end
