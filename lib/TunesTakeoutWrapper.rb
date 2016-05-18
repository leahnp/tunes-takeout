require 'httparty'

# class ChuckApp
#   BASE_URL = "https://tunes-takeout-api.herokuapp.com/"
#   attr_reader 

#   def initialize(data)
#     # @name = data["name"]
#     # @moves = data["moves"]
#     # @sprites = reject_null_sprites(data["sprites"])
#   end

#   # def sprite_urls
#   #   sprites.values
#   # end

#   # def favorite_move
#   #   HTTParty.get(moves.sample["move"]["url"]).parsed_response
#   # end

#   def self.find(id)
#     # http://pokeapi.co/api/v2/pokemon/25/
#     # find a pokemon with the passed id
#     data = HTTParty.get(BASE_URL + "v1/search?query=avocado&limit=3").parsed_response

#     # return an instance of pokemon for that id
#     self.new(data)
#   end

#   # private

#   # def reject_null_sprites(sprite_hash)
#   #   sprite_hash.reject do |name, url|
#   #     url.nil?
#   #   end
#   # end
# end
# module - a class without instance methods???
module TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com/"
  # def initialize(data)
  # end

  def self.search(keyword)
    @data = HTTParty.get(BASE_URL + "v1/suggestions/search?query=" + keyword).parsed_response
  end

  def self.get_yelp_array(suggestions)
    yelp_array = []
    suggestions.each do |s|
      yelp_array << s["food_id"]
    end
    return yelp_array
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

  def favorite(user, suggestion)
    # call API and say user favorited suggestion
  end

  def get_favorites(user)
    # call API to get all favorites for user
  end
end

# results = TunesTakeoutWrapper.search("avocado")