class Music < ActiveRecord::Base
  attr_reader :name, :images_array, :uri, :type, :url
  SPOTIFY_INSTANCES = []


  def initialize(data)
    @name = data.name
    @uri = data.uri
    @type = data.type
    @url = data.external_urls["spotify"]
    if data.type == "track"
      album = data.album
      @images_array = album.images
    else
      @images_array = data.images
    end
  end

  def self.find(spotify_hash, food_array)
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
    # go through each pairing id and add music info
    food_array.each do |subarray|
      # find suggestion from hash
      suggestion_id = subarray[0]

      # set id and music type
      id = spotify_hash[suggestion_id][:music_id]
      type = spotify_hash[suggestion_id][:music_type]

      # pass info to spotify
      if type == "artist"
        data = RSpotify::Artist.find(id)
        raise
        subarray << self.new(data)
      elsif type == "album"
        data = RSpotify::Album.find(id)
        subarray << self.new(data)
      else
        data = RSpotify::Track.find(id)
        subarray << self.new(data)
      end

    end
    return food_array
  end

end
