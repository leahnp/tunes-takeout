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
    return yelp_hash
  end

  def self.get_spotify_arrays(suggestions)
    spotify_hash = {}
    suggestions.each do |s|
      spotify_hash[s["id"]] = {
      music_id: s["music_id"],
      music_type: s["music_type"]
    }
    end
    return spotify_hash
  end

  def self.favorite(user, suggestion)
    # call API and say user favorited suggestion
    response = HTTParty.post(BASE_URL + "v1/users/#{user}/favorites.json",
    {
      "suggestion": suggestion
      })
    raise
  end

  def get_favorites(user)
    # call API to get all favorites for user
  end

  def self.top(n)
    # return is array of arrays [pair_id, food_instance, music_instance]
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