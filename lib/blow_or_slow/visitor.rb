require 'date'
require 'rest_client'

module BlowOrSlow
  class Visitor
    def initialize position, key, options
      @position = position
      @api_key = key
      @options = options || {}
      @base_url = "https://api.forecast.io/forecast/#{@api_key}/#{@position[:lat]},#{@position[:long]}"
    end

    def get(date)
      @date = date

      response = RestClient.get url, { :params => @options }
      response.body
    end

    def url
      @base_url + ",#{@date.to_time.to_i}"
    end

  end
end