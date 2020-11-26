# frozen_string_literal: true

require_relative 'page'

module KaktusKredit
  class Job
    def initialize(notification)
      @notification = notification
    end

    def scheduled?(now)
      now.minute.zero? and now.hour.between?(12, 20)  # every hour from 12:00 to 20:00
    end

    def process
      page = Page.new.properties
      @notification.notify(page[:content]) if page[:changed?]
    end
  end
end
