# frozen_string_literal: true

require 'net/http'

module CzechWord
  class SlovnikCizichSlovPage
    def initialize(from, to)
      @from = from
      @to = to
    end

    def html
      Net::HTTP.get(URI(url))
    end

    def url
      url = format('%s/web.php/top100', base_url)
      url += format('/%d-%d', @from, @to) unless @from.zero?
      url
    end

    def base_url
      'https://slovnik-cizich-slov.abz.cz'
    end
  end
end
