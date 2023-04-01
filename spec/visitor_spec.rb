require 'spec_helper'
require 'json'
require 'visitor'

module BlowOrSlow
  describe Visitor do
    before(:all) do
      @key = '6c3c695fbc7b7cc89be3b95597bfe791'
      @position = { :lat => '52.59748452', :long => '-1.995865713' }
      @options = {:api => :darkskies}
    end

    it "returns an HTML document when given a date and location" do
      visitor = Visitor.new(@position, @key, @options)
      
      json = visitor.get(Date.parse('2012-12-26'))
      json.should be_a_kind_of(String)
      data = JSON.parse(json)
      data.should be_a_kind_of(Hash)
    end

    it "generates a weatherbase URL when given a date and location" do
      visitor = Visitor.new(@position, @key, :api => :darkskies)
      visitor.get(Date.parse('2012-12-26'))
      visitor.url.should == 'https://api.forecast.io/forecast/6c3c695fbc7b7cc89be3b95597bfe791/52.59748452,-1.995865713,1356480000'
    end
  end

end