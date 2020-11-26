# frozen_string_literal: true

require_relative 'random_facts'

module Fact
  class Job
    def initialize(notification, database)
      @notification = notification
      @database = database
    end

    def scheduled?(now)
      now.minute.zero? and now.hour.even? and now.hour.between?(9, 22)  # every 2nd hour from 9 to 22
    end

    def process
      fact = RandomFacts.new(@database).fact
      @notification.notify(fact.properties[:text])
      fact.delete
    end
  end
end
