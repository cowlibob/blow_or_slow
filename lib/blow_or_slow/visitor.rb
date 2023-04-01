require 'date'
require 'rest_client'

module BlowOrSlow
  class Visitor
    def initialize position, key, options
      @position = position
      @api_key = key
      @options = options.dup || {}
      @api = options[:api]
    end

    def get(date)
      @date = date

      case @api
      when :darkskies
        response = RestClient.get darkskies_url, { :params => @options }
        response.body
      when :metoffice
        fetch_site
        response = RestClient.get metoffice_url, { params: metoffice_params }
        response.body
      else
        raise "Unknown weather API (#{@api.inspect}. Options are currently :darkskies and :visual_crossing"
      end
    end

    def darkskies_url
      "https://api.forecast.io/forecast/#{@api_key}/#{@position[:lat]},#{@position[:long]},#{@date.to_time.to_i}"
    end

    def metoffice_api
      if @options[:metoffice_site_id].blank?
        fetch_metoffice_site_id
      end

      "http://datapoint.metoffice.gov.uk/public/data/val/wxobs/all/json/sitelist#{}"
    end

    def metoffice_params
      {
        key: @api_key
      }
    end

  end
end