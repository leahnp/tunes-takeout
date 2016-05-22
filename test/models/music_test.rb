require 'test_helper'

class MusicTest < ActiveSupport::TestCase
  test "find method correctly identifies type of music" do
    food_array = [["Vz0KQY-RRwADboE-", "#<Food:0x007ff73a6439b0>"]]
    spotify_hash = {"Vz0KQY-RRwADboE-"=>{music_id:"1OYLLmDS0pJVFRbUo19vrG", music_type:"album"}}

    result = Music.find(spotify_hash, food_array)
    test = result[0][2]
    assert_equal test.type, "album"
  end

  test "outputs music instance final array correctly" do
    food_array = [["Vz0KQY-RRwADboE-", "Food:0x007ff73a6439b0"]]
    spotify_hash = {"Vz0KQY-RRwADboE-"=>{music_id:"1OYLLmDS0pJVFRbUo19vrG", music_type:"album"}}

    result = Music.find(spotify_hash, food_array)
    assert_equal result[0].length, 3

    assert_equal result[0][2].class, Music
  end
end
