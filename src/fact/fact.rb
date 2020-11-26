# frozen_string_literal: true

require 'sqlite3'

module Fact
  class Fact
    def initialize(id, database)
      @id = id
      @database = database
    end

    def properties
      @database.execute 'SELECT id, text FROM facts WHERE id = ?', @id do |fact|
        id, text = fact
        return {
          id: id,
          text: text
        }
      end
    end

    def delete
      @database.execute 'DELETE FROM facts WHERE id = ?', @id
    end
  end
end
