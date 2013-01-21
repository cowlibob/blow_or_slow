require 'nokogiri'

module BlowOrSlow
  class WeatherMan
    
    def initialize source
      @source = source
      @rows = []
      @columns = {}
      @report = []
    end

    def report(time)
      validate_time time
      @report = Report.new
      find(time)
      @report
    end


    private


    def find(time)
      table = find_table(Nokogiri::HTML(@source))
      filter_rows(table, time)
    end

    def find_table(doc)
      tables = doc.css('table')
      tables.each do |table|
        column_headers = table.css('thead tr th').children
        if column_headers.first && column_headers.first.text? && column_headers.first.text.downcase == 'local time'
          @columns[:time] = column_for('time', column_headers)
          @columns[:direction] = column_for('direction', column_headers)
          @columns[:magnitude] = column_for('speed', column_headers)
          return table
        end
      end
      raise 'Hourly weater table not found on page'
    end

    def filter_rows(table, time)
      
      table.css('tr').each do |tr|
        if tr.children.first.text =~ time_filter(time)
          values = tr.children.collect(&:text)
          @report << {
            time: values[@columns[:time]].split.first,
            direction: values[@columns[:direction]].split.first,
            magnitude: values[@columns[:magnitude]].split.first.to_f
          }

        end
      end
    end

    def column_for(title, headers)
      headers.find_index{|h| h.text.downcase.include? title}
    end

    def time_filter(time)
      Regexp.new('^' + time.gsub(/:(\d\d)/, ':\d\d'))
    end

    def validate_time(time)
      raise 'Invalid time' unless time =~ /^\d\d:\d\d/
    end
  end

end