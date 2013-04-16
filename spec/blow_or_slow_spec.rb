require "spec_helper"
require 'activesupport'

require 'blow_or_slow'

describe BlowOrSlow do
  it "should return a report" do
    date = DateTime.parse('2012-12-26 12:00')
    logger = ActiveSupport::BufferedLogger.new(File.join(File.dirname(__FILE__), '..', 'log', 'spec.log'))
    key = '6c3c695fbc7b7cc89be3b95597bfe791'
    position = { :lat => '52.59748452', :long => '-1.995865713' }
    report = BlowOrSlow.report_for(date, position, key, logger)
    #report.first[:time].should eq '12:20'
  end
end