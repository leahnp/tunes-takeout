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

  def self.find(biz_id_array)
    # parameters = { term: params[:term], limit: 16 }
    # business id
    # /v2/business/{id}

    biz_id_array.each do |biz_id|

      data = Yelp.client.business(biz_id)
      raise

    # @yelp_data = HTTParty.get(BASE_URL + biz_id).parsed_response
    # @yelp_data = HTTParty.get("https://api.yelp.com/v2/business/yelp-san-francisco").parsed_response
    
    FOOD_OPTIONS << self.new(data)
    end
    return FOOD_OPTIONS
  end
end


