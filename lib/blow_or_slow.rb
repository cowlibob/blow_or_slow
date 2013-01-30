require "blow_or_slow/version"
require "blow_or_slow/visitor"
require "blow_or_slow/weather_man"
require "blow_or_slow/report"

module BlowOrSlow
  def self.report_for(date_time)
    raise "Invalid parameter" unless date_time.respond_to? :strftime

    visitor = BlowOrSlow::Visitor.new
    html = visitor.get(date_time.strftime("%Y-%m-%d"))
    
    weatherman = BlowOrSlow::WeatherMan.new(html)
    weatherman.report(date_time.strftime("%H:%M %p"))
  end
end