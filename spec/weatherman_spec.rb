require 'spec_helper'
require 'blow_or_slow'


describe BlowOrSlow::WeatherMan do

  before(:all) do
    @key = '6c3c695fbc7b7cc89be3b95597bfe791'
    @position = { :lat => '52.59748452', :long => '-1.995865713' }
    @options = {api: :darkskies}
    #@race_start = DateTime.new(2012, 12, 26, 12, 0)
    @race_start = DateTime.parse("Wed, 26 Dec 2012 12:00:00 +0000")
    @visitor = BlowOrSlow::Visitor.new(@position, @key, @options)
    @html = @visitor.get(@race_start)
    
    @weatherman = BlowOrSlow::WeatherMan::DarkSkies.new(@html)
  end

  it "returns an array from report" do
    report = @weatherman.report(@race_start)
    report.should be_a_kind_of(Enumerable)
  end
   
  describe BlowOrSlow::Report do
    before(:all) do
      @report = @weatherman.report(@race_start)
    end

    it "should identify nearest time" do
      @report.first[:time].should eq 1356523200
    end

    it "should contain one or more status" do
      @report.count.should eq 1

      @report.first[:direction].should eq 219
      @report.first[:magnitude].should eq 3.19
    end
  end

  it "should accept a time for the report" do
    expect {
      @weatherman.report('')
    }.to raise_error('Invalid time')

    expect {
      @weatherman.report('james')
    }.to raise_error('Invalid time')

    @weatherman.report(@race_start)
  end

  # it "should produce a regexp in response to time_filter" do
  #   @weatherman.send(:time_filter, '12:00').should eq /^12:\d\d/
  # end

end