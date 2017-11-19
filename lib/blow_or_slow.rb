require "blow_or_slow/version"
require "blow_or_slow/visitor"
require "blow_or_slow/weather_man"
require "blow_or_slow/report"

module BlowOrSlow

  def self.report_for(date_time, position, key, logger)
    raise "Invalid parameter" unless date_time.respond_to? :strftime

    options = {}
    options[:units] = :uk
    visitor = BlowOrSlow::Visitor.new(position, key, options)
    json = visitor.get(date_time) 
    
    weatherman = BlowOrSlow::WeatherMan.new(json)
    begin
      weatherman.report(date_time)
    rescue StandardError => e
      logger.info(visitor.url)
      logger.warn(e.message)
    end
  end
end