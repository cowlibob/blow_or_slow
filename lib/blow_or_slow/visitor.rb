require 'date'
require 'rest_client'

module BlowOrSlow
  class Visitor
    def initialize
      @site_id = 33451
      @base_url = "http://www.weatherbase.com/weather/weatherhourly.php3"
    end

    def get(date)
      @date = date

      response = RestClient.get url, {params: {s: @site_id, date: @date, units: 'us'}}
      response.body
    end

    def url
      base = "http://www.weatherbase.com/weather/weatherhourly.php3?s=33451&date=#{@date}"
      
      base
    end

  end
end