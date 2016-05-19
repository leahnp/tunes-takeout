class Music < ActiveRecord::Base

  def self.find(spotify_array)
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])

  # Now you can access playlists in detail, browse featured content and more
    spotify_array.each do |array|
      # me = RSpotify::User.find(array[1])
      type = array[0].capitalize.to_sym
      id = array[1]
      # trying to pass it "aritst" etc dynamically - currrently NOT WORKING
      me = RSpotify::type.find(id)
      # return me.playlists #=> (Playlist array)
      # return type
    end
  end
end
