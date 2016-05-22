require_relative '../../lib/TunesTakeoutWrapper'

class SuggestionsController < ApplicationController

# index: shows top 20 suggestions, ranked by total number of favorites
  def index
    if current_user
      favorites = TunesTakeoutWrapper.favorites(current_user.uid)
      # array of pairs user has already favorited
      @favorites = favorites["suggestions"]
    else
      @favorites = []
    end

    @results = TunesTakeoutWrapper.top(9)
    @yelp = {}
    @spotify_hash = {}
    @results.each do |pair|
      @yelp.merge!(TunesTakeoutWrapper.get_yelp_hash([pair["suggestion"]]))
      @spotify_hash.merge!(TunesTakeoutWrapper.get_spotify_hash([pair["suggestion"]]))
    end
    @yelp_array = Food.find(@yelp)
    # info is array of arrays [pair_id, food_instance, music_instance]
    @info = Music.find(@spotify_hash, @yelp_array)
  end

  def show
    favorites = TunesTakeoutWrapper.favorites(current_user.uid)
    # array of pairs user has already favorited
    @favorites = favorites["suggestions"]

    # hash['suggestions'] KEY with VALUE as array of hashes include keys ("id" "food_id", "music_type", "music_id")
    @results = TunesTakeoutWrapper.search(params[:keyword])
    @yelp = TunesTakeoutWrapper.get_yelp_hash(@results["suggestions"])
    @yelp_array = Food.find(@yelp)
    @spotify_hash = TunesTakeoutWrapper.get_spotify_hash(@results["suggestions"])
    # info is array of arrays [pair_id, food_instance, music_instance]
    @info = Music.find(@spotify_hash, @yelp_array)
    render :show
  end

  # favorites: shows all suggestions favorited by the signed-in User
  def favorites
    @yelp = {}
    @spotify_hash = {}
    user = current_user.uid
    # returns hash with key "suggestion" and value is array of pair-ids
    favorites = TunesTakeoutWrapper.favorites(user)
    favorites = favorites["suggestions"]
    favorites = TunesTakeoutWrapper.search_by_pair(favorites)
    favorites.each do |pair|
      @yelp.merge!(TunesTakeoutWrapper.get_yelp_hash([pair["suggestion"]]))
      @spotify_hash.merge!(TunesTakeoutWrapper.get_spotify_hash([pair["suggestion"]]))
    end
    @yelp_array = Food.find(@yelp)
    # info is array of arrays [pair_id, food_instance, music_instance]
    @info = Music.find(@spotify_hash, @yelp_array)
    # raise
  end

# favorite: adds a suggestion into the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
  def favorite
    user = current_user.uid
    response = TunesTakeoutWrapper.favorite(user, params["suggestion"])
    redirect_to root_path
  end

# unfavorite: removes a suggestion from the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
  def destroy_favorite
    user = current_user.uid
    response = TunesTakeoutWrapper.destroy_favorite(user, params["suggestion"])
    redirect_to root_path
  end
end
