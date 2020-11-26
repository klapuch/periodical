# frozen_string_literal: true

module CzechWord
  class FirebaseWord
    DOCUMENT = 'words'
    def initialize(client)
      @client = client
    end

    def value
      response = @client.get(DOCUMENT, { orderBy: '"position"', limitToFirst: 1 })
      raise format('Response was not successfull - %s', response.raw_body) unless response.success?
      raise 'No more words.' if response.body.nil?

      id, word = response.body.first
      @id = id
      word
    end

    def delete
      raise 'No word to delete.' if @id.nil?

      response = @client.delete("#{DOCUMENT}/#{@id}")
      raise format('Response was not successfull - %s', response.raw_body) unless response.success?
    end
  end
end
