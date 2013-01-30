require "spec_helper"

require 'blow_or_slow'

describe BlowOrSlow do
  it "should return a report" do
    date = DateTime.parse('2012-12-26 12:00')
    report = BlowOrSlow.report_for(date)

    report.first[:time].should eq '12:20'
  end
end