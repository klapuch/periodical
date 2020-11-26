# frozen_string_literal: true

require_relative 'firebase_words'
require_relative 'slovnik_cizich_slov_words'
require_relative 'slovnik_cizich_slov_pages'
require_relative 'unique_words'

module CzechWord
  class Import
    def initialize(firebase)
      @firebase = firebase
    end

    def process
      FirebaseWords.new(
        UniqueWords.new(SlovnikCizichSlovWords.new(SlovnikCizichSlovPages.new)),
        @firebase
      ).add
    end
  end
end
