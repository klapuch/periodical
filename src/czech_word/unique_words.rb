# frozen_string_literal: true

module CzechWord
  class UniqueWords
    def initialize(origin)
      @origin = origin
    end

    def all
      words = []
      @origin.all.select do |word|
        unique = words.none? word[:value]
        words.push(word[:value])
        unique
      end
    end
  end
end
