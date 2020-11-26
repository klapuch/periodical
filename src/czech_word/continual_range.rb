# frozen_string_literal: true

module CzechWord
  class ContinualRange
    def initialize(from, to, step)
      @from = from
      @to = to
      @step = step
      @max = to
    end

    def current
      [@from, @from + @step]
    end

    def next
      _, to = current
      @from = to + 1
      @to += @step
    end

    def last?
      from, = current
      from >= @max
    end

    def steps
      (@from..@to).to_a
    end
  end
end
