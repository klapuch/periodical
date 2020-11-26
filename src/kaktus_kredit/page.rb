# frozen_string_literal: true

require_relative 'page_http_selection'
require_relative 'page_file_selection'

module KaktusKredit
  class Page
    def properties
      file_selection = PageFileSelection.new('kredit')
      http_selection = PageHttpSelection.new('https://www.mujkaktus.cz/homepage').value.strip
      changed = file_selection.read.strip != http_selection
      file_selection.write(http_selection) if changed
      {
        changed?: changed,
        content: http_selection
      }
    end
  end
end
