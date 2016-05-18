require 'yelp'
require 'httparty'

class Food < ActiveRecord::Base
  BASE_URL = "https://api.yelp.com/v2/business/"
  #urban-curry-san-francisco?actionlinks=True
  # get from yelp
  def self.search(biz_id)
    # parameters = { term: params[:term], limit: 16 }
    # business id
    # /v2/business/{id}
    @yelp_data = Yelp.client.business(biz_id)
    # @yelp_data = HTTParty.get(BASE_URL + biz_id).parsed_response
    # @yelp_data = HTTParty.get("https://api.yelp.com/v2/business/yelp-san-francisco").parsed_response
    

    raise
  end
end


