require 'yelp'
# require 'httparty'

class Food < ActiveRecord::Base
  # BASE_URL = "https://api.yelp.com/v2/business/"
  #urban-curry-san-francisco?actionlinks=True
  # get from yelp

  attr_reader :name
  FOOD_OPTIONS = []

  def initialize(data)
    @name = data.business.name
      # @yelp_data.business.name

  end

  def self.find(biz_id_array)
    # parameters = { term: params[:term], limit: 16 }
    # business id
    # /v2/business/{id}

    biz_id_array.each do |biz_id|

      data = Yelp.client.business(biz_id)
    # @yelp_data = HTTParty.get(BASE_URL + biz_id).parsed_response
    # @yelp_data = HTTParty.get("https://api.yelp.com/v2/business/yelp-san-francisco").parsed_response
    
      # FOOD_OPTIONS << 
      self.new(data)
    end
    
  end
end


