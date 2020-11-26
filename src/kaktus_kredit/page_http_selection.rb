# frozen_string_literal: true

require 'nokogiri'
require 'httparty'

module KaktusKredit
  class PageHttpSelection
    def initialize(url)
      @url = url
    end

    def value
      Nokogiri::HTML(page).xpath(
        'normalize-space(
          //div[@class="box-bubble"]//div[@class="journal-content-article"][1]//p[2]/text()
        )'
      ).to_s
    end

    def page
      HTTParty.get(@url, follow_redirects: true).body
    end
  end
end
