require_relative '../../lib/TunesTakeoutWrapper'

# include TunesTakeoutWrapper

class SuggestionsController < ApplicationController

# index: shows top 20 suggestions, ranked by total number of favorites
  def index
    @results = TunesTakeoutWrapper.top(9)
    @yelp = {}
    @spotify_hash = {}
    @results.each do |pair|
      @yelp.merge!(TunesTakeoutWrapper.get_yelp_hash([pair["suggestion"]]))
      @spotify_hash.merge!(TunesTakeoutWrapper.get_spotify_arrays([pair["suggestion"]]))
    end
    @yelp_array = Food.find(@yelp)
    # info is array of arrays [pair_id, food_instance, music_instance]
    @info = Music.find(@spotify_hash, @yelp_array)
  end

  def show
    # hash['suggestions'] KEY with VALUE as array of hashes include keys ("id" "food_id", "music_type", "music_id")
    @results = TunesTakeoutWrapper.search(params[:keyword])
    # raise
    @yelp = TunesTakeoutWrapper.get_yelp_hash(@results["suggestions"])
    @yelp_array = Food.find(@yelp)
    @spotify_hash = TunesTakeoutWrapper.get_spotify_arrays(@results["suggestions"])
    # info is array of arrays [pair_id, food_instance, music_instance]
    @info = Music.find(@spotify_hash, @yelp_array)
    render :show
  end

# favorites: shows all suggestions favorited by the signed-in User
  def favorites
  end

# favorite: adds a suggestion into the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
  def favorite
    user = current_user.uid
    response = TunesTakeoutWrapper.favorite(user, params["suggestion"])
    raise
  end

# unfavorite: removes a suggestion from the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
  def unfavorite
  end
end
