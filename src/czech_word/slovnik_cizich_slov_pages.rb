# frozen_string_literal: true

require_relative 'slovnik_cizich_slov_page'
require_relative 'continual_range'

module CzechWord
  class SlovnikCizichSlovPages
    def all
      pages = []
      range = ContinualRange.new(0, 1000, 50)
      until range.last?
        from, to = range.current
        pages.append(SlovnikCizichSlovPage.new(from, to))
        range.next
      end
      pages
    end
  end
end
