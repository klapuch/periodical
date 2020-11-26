# frozen_string_literal: true

require_relative 'message'
require_relative 'quote'

module CzechQuote
  class Job
    def initialize(notification)
      @notification = notification
    end

    def scheduled?(now)
      %w[11:00 15:00 18:00].include? format('%02d:%02d', now.hour, now.minute)
    end

    def process
      quote = Quote.new.value
      @notification.notify(
        Message.new(quote[:text], quote[:origin], quote[:about]).to_s
      )
    end
  end
end
