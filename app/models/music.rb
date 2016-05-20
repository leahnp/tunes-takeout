class Music < ActiveRecord::Base
  attr_reader :name, :images_array, :uri, :type
  SPOTIFY_INSTANCES = []


  def initialize(data)
    @name = data.name
    @uri = data.uri
    @type = data.type
    if data.type == "track"
      album = data.album
      @images_array = album.images
    else
      @images_array = data.images
    end
  end

  #   def self.find(hash)
  #   hash.each do |key, value|
  #     data = Yelp.client.business(value[:food_id])
  #     FOOD_OPTIONS << [key, self.new(data)]
  #   end
  #   return FOOD_OPTIONS
  # end


  def self.find(hash, food_array)
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
    # go through each pairing id and add music info
    food_array.each do |subarray|
      # find suggestion from hash
      suggestion_id = subarray[0]

      # set id and music type
      id = hash[suggestion_id][:music_id]
      type = hash[suggestion_id][:music_type]

      # pass info to spotify
      if type == "artist"
        data = RSpotify::Artist.find(id)
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
