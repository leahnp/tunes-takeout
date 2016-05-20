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

  def self.find(hash)
    hash.each do |key, value|
      data = Yelp.client.business(value[:food_id])
      FOOD_OPTIONS << [key, self.new(data)]
    end
    return FOOD_OPTIONS
  end
end


