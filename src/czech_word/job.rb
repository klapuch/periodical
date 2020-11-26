# frozen_string_literal: true

require_relative 'firebase_word'

module CzechWord
  class Job
    def initialize(notification, firebase)
      @notification = notification
      @firebase = firebase
    end

    def scheduled?(now)
      %w[12:00 16:00 19:00].include? format('%02d:%02d', now.hour, now.minute)
    end

    def process
      word = FirebaseWord.new(@firebase)
      value = word.value()
      @notification.notify(
        format('<a href="%s">%s</a>', value['link'], value['value'])
      )
      word.delete
    end
  end
end
