require 'yelp'
# require 'httparty'

class Food < ActiveRecord::Base
  # BASE_URL = "https://api.yelp.com/v2/business/"
  #urban-curry-san-francisco?actionlinks=True
  # get from yelp

  attr_reader :name, :url, :image_url, :phone, :address
  FOOD_OPTIONS = []

  def initialize(data)
    @name = data.business.name
    @url = data.business.url
    @image_url = data.business.image_url
    @phone = data.business.phone
    @address = data.business.location.display_address
  end

  def self.find(yelp_hash)

    # I want this to add another key value pair to value in the yelp_hash
    yelp_hash.each do |key, value|
      data = Yelp.client.business(value["food_id"])
      yelp_hash[key][value] = {
        yelp_data: self.new(data)
      }
    end






    # biz_id_array.each do |biz_id|
    #   data = Yelp.client.business(biz_id)
    #   FOOD_OPTIONS << self.new(data)
    # end
    raise
    return yelp_hash
  end
end


