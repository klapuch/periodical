# frozen_string_literal: true

module KaktusKredit
  class PageFileSelection
    def initialize(name)
      @name = name
    end

    def read
      File.exist?(filename) ? File.read(filename) : ''
    end

    def write(content)
      File.write(filename, content)
    end

    def filename
      format('%s/data/%s.txt', File.dirname(__FILE__), @name)
    end
  end
end
