require 'httparty'

module TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com/"
  # def initialize(data)
  # end

  def self.search(keyword)
    @data = HTTParty.get(BASE_URL + "v1/suggestions/search?query=" + keyword).parsed_response
  end

  def self.get_yelp_hash(suggestions)
    # hash with suggestion id as key and value is hash with food_id key, id value pair
    yelp_hash = {}
    suggestions.each do |s|
      yelp_hash[s["id"]] = {
        food_id: s["food_id"]
      }
    end
    raise
    return yelp_hash
  end

  def self.get_spotify_arrays(suggestions)
    music_type_array = []
    music_id_array = []
    suggestions.each do |s|
      music_id_array << s["music_id"]
      music_type_array << s["music_type"]
    end
    return music_type_array.zip(music_id_array)
  end

  def self.favorite(user, suggestion)
    # call API and say user favorited suggestion
    response = HTTParty.post(BASE_URL + "v1/users/#{user}/favorites.json",
    {
      "suggestion": suggestion
      })
    raises
  end

  def get_favorites(user)
    # call API to get all favorites for user
  end

  def self.top(n)
    return_data = []
    data = HTTParty.get(BASE_URL + "v1/suggestions/top?limit=" + n.to_s).parsed_response
    id_array = data["suggestions"]
    id_array.each do |id|
      a = HTTParty.get(BASE_URL + "v1/suggestions/" + id).parsed_response
      return_data << a
    end
    return return_data
  end
end

# results = TunesTakeoutWrapper.search("avocado")