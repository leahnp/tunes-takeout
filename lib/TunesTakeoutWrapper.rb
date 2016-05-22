require 'httparty'

module TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com/"

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

  def self.get_spotify_hash(suggestions)
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
    response = HTTParty.post(BASE_URL + "v1/users/#{user}/favorites",
    body: {
      "suggestion": suggestion
      }.to_json)
    # need to add error handling
  end

    def self.destroy_favorite(user, suggestion)
    # call API and say user favorited suggestion
    response = HTTParty.delete(BASE_URL + "v1/users/#{user}/favorites",
    body: {
      "suggestion": suggestion
      }.to_json)
    # need to add error handling
  end

  def self.favorites(user_id)
    favorites = HTTParty.get(BASE_URL + "/v1/users/#{user_id}/favorites").parsed_response
  end

  def self.top(n)
    # return is array of arrays [pair_id, food_instance, music_instance]
    data = HTTParty.get(BASE_URL + "v1/suggestions/top?limit=" + n.to_s).parsed_response
    id_array = data["suggestions"]
    return_data = TunesTakeoutWrapper.search_by_pair(id_array)
    return return_data
  end

  def self.search_by_pair(id_array)
    return_data = []
    id_array.each do |id|
      a = HTTParty.get(BASE_URL + "v1/suggestions/" + id).parsed_response
      return_data << a
    end
    return return_data
  end
end