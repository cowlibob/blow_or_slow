require 'json'

module BlowOrSlow
  class WeatherMan
    
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

      build_report(find_weather_record(time))
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



    # def find(race_time)
    #   table = find_table(Nokogiri::HTML(@source))
    #   filter_rows(table, race_time)
    # end

    # def find_table(doc)
    #   tables = doc.css('table.tblAlmanacHourly')
    #   tables.each do |table|
    #     column_headers = table.css('th').children
    #     if column_headers.first.try(:text).try(:downcase).try(:include?, 'time')
    #       @columns[:time] = column_for('time', column_headers)
    #       @columns[:wind] = column_for('wind', column_headers)
    #       return table
    #     end
    #   end
    #   raise 'Hourly weather table not found on page'
    # end

    # def filter_rows(table, race_time)
    #   table.css('tr').each do |tr|
    #     debugger        
    #     time = Time.parse(tr.children.first.text)
    #     if (time - race_time).abs < 1.hour
    #       collect_data(tr.children.collect(&:text))
    #     end
    #   end
    # end

    # def collect_data(content)
    #   @report << {
    #     :time => values[@columns[:time]].split.first,
    #     :direction => values[@columns[:wind]].match(/^\w*[^\s\d]/),
    #     :magnitude => values[@columns[:wind]].match(/\d.*/)
    #   }
    # end

    # def column_for(title, headers)
    #   headers.find_index{|h| h.text.downcase.include? title}
    # end

    # def time_filter(time)
    #   Regexp.new('^' + time.gsub(/:(\d\d)/, ':\d\d'))
    # end

    def validate_time(time)
      raise 'Invalid time' unless time.is_a? Date
    end
  end

end