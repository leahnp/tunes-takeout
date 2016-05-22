require 'uri'
require 'yelp'

class Food
  attr_reader :name, :url, :image_url, :phone, :address

  def initialize(data)
    @name = data.business.name
    @url = data.business.url
    @image_url = data.business.image_url
    @phone = data.business.phone
    @address = data.business.location.display_address
  end

  def self.find(hash)
    food_options = []

    hash.each do |key, value|
      # yelp ruby API doesn't URL encoded the business id passed to it
      # https://github.com/Yelp/yelp-ruby/issues/51
      encoded_food_id = URI.escape(value[:food_id])
      data = Yelp.client.business(encoded_food_id)
      food_options << [key, self.new(data)]
    end

    return food_options
  end
end


