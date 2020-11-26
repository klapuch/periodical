# frozen_string_literal: true

require 'sqlite3'
require_relative 'fact'

module Fact
  class RandomFacts
    def initialize(database)
      @database = database
    end

    def fact
      @database.execute 'SELECT id FROM facts ORDER BY id LIMIT 1' do |fact|
        id, = fact
        return Fact.new(id, @database)
      end
    end
  end
end
