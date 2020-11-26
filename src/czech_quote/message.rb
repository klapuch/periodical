# frozen_string_literal: true

module CzechQuote
  class Message
    def initialize(text, origin, about)
      @text = text
      @origin = origin
      @about = about
    end

    def to_s
      format(
        "<em>%s</em>\n\n<strong>%s</strong>",
        @text,
        @origin
      ) + (@about == '' ? '' : format(' - %s', @about))
    end
  end
end
