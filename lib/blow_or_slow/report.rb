module BlowOrSlow
  class Report
    include Enumerable

    def initialize
      @observations = []
    end

    def [](index)
      @observations[index]
    end

    def []=(index, value)
      @observations[index] = value
    end

    def <<(value)
      @observations << value
    end

    def each
      @observations.each {|ob| yield(ob)}
    end

    def count
      @observations.count
    end

  end
end