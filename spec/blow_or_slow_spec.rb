require "spec_helper"
require 'active_support'

require 'blow_or_slow'
require 'ruby_jard'

describe BlowOrSlow do
  it "darkskies api should return a report" do
    date = DateTime.parse('2012-12-26 12:00')
    logger = ActiveSupport::Logger.new(File.join(File.dirname(__FILE__), '..', 'log', 'spec.log'))
    key = '6c3c695fbc7b7cc89be3b95597bfe791'
    position = { :lat => '52.59748452', :long => '-1.995865713' }
    report = BlowOrSlow.report_for(date, position, key, logger, :api => :darkskies)
    report.first[:time].should eq date.to_time.to_i
  end

  it "visualcrossing api should return a report" do
  	date = DateTime.parse('2020-12-27 12:00')
    logger = ActiveSupport::Logger.new(File.join(File.dirname(__FILE__), '..', 'log', 'spec.log'))
	key = "QNHGQ6WYZJ2HML2H9JYHMCXNP"
	position = { :lat => '52.59748452', :long => '-1.995865713' }
	report = BlowOrSlow.report_for(date, position, key, logger, :api => :visual_crossing)  
    report.first[:time].should eq date.to_time.to_i
  end	
end