# frozen_string_literal: true

module CzechWord
  class FirebaseWords
    DOCUMENT = 'words'
    def initialize(origin, firebase)
      @origin = origin
      @firebase = firebase
    end

    def add
      @origin.all.each do |word|
        @firebase.push(
          DOCUMENT,
          {
            position: word[:position],
            value: word[:value],
            link: word[:link]
          }
        )
      end
    end
  end
end
