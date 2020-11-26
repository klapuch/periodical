# frozen_string_literal: true

require 'nokogiri'

module CzechWord
  class SlovnikCizichSlovWords
    def initialize(pages)
      @pages = pages
    end

    def all
      position = 0
      words = []
      @pages.all.each do |page|
        html = Nokogiri::HTML(page.html())
        values = html.xpath('//div[@id="content_part"]//div[@style]/a/text()')
        links = html.xpath('//div[@id="content_part"]//div[@style]/a/@href')
        links = absolute_links(page.base_url, links)
        values.zip(links).each do |word|
          value, link = word
          position += 1
          words.push({ position: position, value: value, link: link })
        end
      end
      words
    end

    def absolute_link(url, path)
      "#{url}/#{path.to_s.delete_prefix('/')}"
    end

    def absolute_links(url, links)
      links.map { |path| absolute_link(url, path) }
    end
  end
end
