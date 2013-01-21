require 'spec_helper'
require 'visitor'

module BlowOrSlow
  describe Visitor do
    it "returns an HTML document when given a date and location" do
      visitor = Visitor.new
      
      html = visitor.get(Date.parse('2012-12-26'))
      html.should be_a_kind_of(String)
      html.should include('Crookes')
    end

    it "generates a weatherbase URL when given a date and location" do
      visitor = Visitor.new
      visitor.get(Date.parse('2012-12-26'))
      visitor.url.should == 'http://www.weatherbase.com/weather/weatherhourly.php3?s=33451&date=2012-12-26'
    end
  end

end