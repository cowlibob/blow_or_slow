require 'json'

module BlowOrSlow
  module WeatherMan
    class Base
    
      def initialize source
        @source = source
        @rows = []
        @columns = {}
        @report = []
      end

      def report(time)
        @weather_records = JSON.parse(@source)
        @report = Report.new

        validate_time time

        record = find_weather_record(time)
        build_report(record)
        @report
      end

      private

      def find_weather_record(time)
        record_types = ['currently', 'hourly']
        unix_time = time.to_time.to_i

        # exact time match
        record = @weather_records['currently'][unix_time.to_s]
        return record unless record.nil?

        # closest time match
        closest = nil
        @weather_records['hourly']['data'].each do |record|
          closest = record if closer?(unix_time, record, closest)
        end

        closest
      end

      def closer?(time, record, closest)
        if closest.nil?
          @closest_distance = (record['time'].to_i - time).abs
          return true  
        end

        distance = (record['time'].to_i - time).abs
        if distance < @closest_distance
          @closest_distance = distance
          return true
        end

        false
      end

      def build_report(weather_record)
        @report << {
          :time => weather_record['time'],
          :direction => weather_record['windBearing'],
          :magnitude => weather_record['windSpeed']
        }
      end

      def validate_time(time)
        raise 'Invalid time' unless time.is_a? Date
      end      
    end

    class MetOffice < Base

    end

  end
end