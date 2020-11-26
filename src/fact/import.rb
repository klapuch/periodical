# frozen_string_literal: true

require 'sqlite3'

module Fact
  class Import
    def initialize(database)
      @database = database
    end

    def process
      @database.execute <<-SQL
        CREATE TABLE facts (
          id integer PRIMARY KEY AUTOINCREMENT,
          text text NOT NULL
        );
      SQL
      File.readlines(format('%s/data/facts.txt', File.dirname(__FILE__))).each do |fact|
        @database.execute 'INSERT INTO facts (text) VALUES (?)', fact
      end
    end
  end
end

Fact::Import.new(SQLite3::Database.new(format('%s/data/facts.db', File.dirname(__FILE__)))).process
