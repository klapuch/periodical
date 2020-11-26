# frozen_string_literal: true

require 'sqlite3'
require 'date'
require 'firebase'
require_relative 'czech_quote/job'
require_relative 'czech_word/job'
require_relative 'kaktus_kredit/job'
require_relative 'fact/job'
require_relative 'notification'
require_relative '../config.local'

jobs = [
  CzechQuote::Job.new(
    Notification::Telegram.new(
      CONFIG[:telegram][:czech_quote][:token],
      CONFIG[:telegram][:czech_quote][:subscribers]
    )
  ),
  CzechWord::Job.new(
    Notification::Telegram.new(
      CONFIG[:telegram][:czech_word][:token],
      CONFIG[:telegram][:czech_word][:subscribers]
    ),
    Firebase::Client.new(
      CONFIG[:firebase][:uri],
      File.open(CONFIG[:firebase][:key_uri]).read
    )
  ),
  KaktusKredit::Job.new(
    Notification::Telegram.new(
      CONFIG[:telegram][:kaktus_kredit][:token],
      CONFIG[:telegram][:kaktus_kredit][:subscribers]
    )
  ),
  Fact::Job.new(
    Notification::Telegram.new(
      CONFIG[:telegram][:one_fact][:token],
      CONFIG[:telegram][:one_fact][:subscribers]
    ),
    SQLite3::Database.new(format('%s/fact/data/facts.db', File.dirname(__FILE__)))
  )
]

now = DateTime.now
jobs.each do |job|
  job.process if job.scheduled? now
end
