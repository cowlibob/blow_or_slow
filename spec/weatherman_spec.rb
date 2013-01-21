require 'spec_helper'

require 'weather_man'
require 'visitor'

describe BlowOrSlow do
  it "should return a report" do
    report = BlowOrSlow.report_for(Date.parse('2012-12-26 12:00'))
  end

  describe BlowOrSlow::WeatherMan do

    before(:all) do
      @visitor = BlowOrSlow::Visitor.new
      @html = @visitor.get(Date.parse('2012-12-26'))
      
      @weatherman = BlowOrSlow::WeatherMan.new(@html)
    end

    it "returns an array from report" do
      report = @weatherman.report('12:00')
      report.should be_a_kind_of(Enumerable)
    end
     
    describe BlowOrSlow::Report do
      before(:all) do
        @report = @weatherman.report('12:00 PM')
      end

      it "should identify nearest time" do
        @report.first[:time].should eq '12:20'
      end

      it "should contain one or more status" do
        @report.count.should eq 2

        @report.first[:direction].should eq 'WSW'
        @report.first[:magnitude].should eq 15.0
      end
    end

    it "should accept a time for the report" do
      expect {
        @weatherman.report('')
      }.to raise_error('Invalid time')

      expect {
        @weatherman.report('james')
      }.to raise_error('Invalid time')

      @weatherman.report('12:00')
    end

    it "should produce a regexp in response to time_filter" do
      @weatherman.send(:time_filter, '12:00').should eq /^12:\d\d/
    end

  end
end