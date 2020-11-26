# frozen_string_literal: true

require 'nokogiri'
require 'net/http'

module CzechQuote
  class Quote
    def value
      html = Nokogiri::HTML(page)
      text = html.xpath(
        'substring(
          //h3[@class="blockquote-text"]/a/text(),
          2,
          string-length(//h3[@class="blockquote-text"]/a/text()) - 2
        )'
      )
      origin = html.xpath('//p[@class="blockquote-origin"]/a/text()')
      about = html.xpath(
        'normalize-space(
          //p[@class="blockquote-origin"]/a/following-sibling::text()
        )'
      )
      {
        text: text.to_s,
        origin: origin.to_s,
        about: about.to_s
      }
    end

    def page
      Net::HTTP.get(URI('https://citaty.net/citaty/nahodny-citat/'))
    end
  end
end
