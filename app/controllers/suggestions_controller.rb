require_relative '../../lib/TunesTakeoutWrapper'

# include TunesTakeoutWrapper

class SuggestionsController < ApplicationController

# index: shows top 20 suggestions, ranked by total number of favorites
  def index
  end

  def show
    # keyword = params[:keyword]
    @results = TunesTakeoutWrapper.search(params[:keyword])
    @yelp = TunesTakeoutWrapper.get_yelp_array(@results["suggestions"])
    @spotify_array = TunesTakeoutWrapper.get_spotify_arrays(@results["suggestions"])

    test = Food.find(@yelp)
    raise
  end

# favorites: shows all suggestions favorited by the signed-in User
  def favorites
  end

# favorite: adds a suggestion into the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
  def favorite
  end

# unfavorite: removes a suggestion from the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
  def unfavorite
  end
end
