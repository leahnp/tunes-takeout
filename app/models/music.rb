class Music < ActiveRecord::Base
  attr_reader :name, :images_array
  SPOTIFY_INSTANCES = []


  def initialize(data)
    @name = data.name
    if data.type == "track"
      album = data.album
      @images_array = album.images
    else
      @images_array = data.images
    end
  end


  def self.find(spotify_array)
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])


    spotify_array.each do |array|
      # break out id and music type
      type = array[0]
      id = array[1]

      # pass info/id to spotify 
      if type == "artist"
        data = RSpotify::Artist.find(id)
        SPOTIFY_INSTANCES << self.new(data)
      elsif type == "album"
        data = RSpotify::Album.find(id)
        SPOTIFY_INSTANCES << self.new(data)
      else
        data = RSpotify::Track.find(id)
        SPOTIFY_INSTANCES << self.new(data)
      end
    end
    # return array of instances
    return SPOTIFY_INSTANCES
  end
end
