require "blow_or_slow/version"
require "blow_or_slow/visitor"
require "blow_or_slow/weather_man"
require "blow_or_slow/report"

module BlowOrSlow
  def self.report_for(date)
    visitor = BlowOrSlow::Visitor.new
    html = visitor.get(Date.parse('2012-12-26'))
    
    weatherman = BlowOrSlow::WeatherMan.new(html)
    weatherman.report('12:00 PM')
  end
end