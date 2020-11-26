# frozen_string_literal: true

require 'net/http'
require 'json'

module Notification
  class Pushover
    def initialize(key, token)
      @key = key
      @token = token
    end

    def notify(message, title)
      Net::HTTP.post_form(
        URI('https://api.pushover.net/1/messages.json'),
        {
          'token' => @token,
          'user' => @key,
          'message' => message,
          'title' => title,
          'html' => 1
        }
      )
    end
  end

  class Telegram
    def initialize(token, subscribers)
      @token = token
      @subscribers = subscribers
    end

    def notify(message)
      @subscribers.each do |subscriber|
        request(
          'sendMessage',
          {
            chat_id: subscriber,
            text: message,
            parse_mode: 'html',
            disable_web_page_preview: true
          }
        )
      end
    end

    def request(endpoint, parameters)
      Net::HTTP.post(
        URI(url(endpoint)),
        parameters.to_json,
        'Content-Type': 'application/json'
      )
    end

    def url(endpoint)
      format('https://api.telegram.org/bot%s/%s', @token, endpoint)
    end
  end
end
