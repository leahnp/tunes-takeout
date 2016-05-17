require_relative '../../lib/TunesTakeoutWrapper'

class SuggestionsController < ApplicationController
# index: shows top 20 suggestions, ranked by total number of favorites
  def index
  end

# favorites: shows all suggestions favorited by the signed-in User
  def favorites
  end

# favorite: adds a suggestion into the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
  def favorite
    # keyword = params[:keyword]
    results = TunesTakeoutWrapper.search(params[:keyword])
    raise
  end

# unfavorite: removes a suggestion from the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
  def unfavorite
  end
end
