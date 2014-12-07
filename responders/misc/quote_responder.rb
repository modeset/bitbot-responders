# encoding: UTF-8
require 'open-uri'

class QuoteResponder < Bitbot::Responder
  include Bitbot::Responder::Wit

  category 'Miscellaneous'
  help 'misc:quote', description: 'Provides a random quote',
    examples: ['give me a quote.', 'inspiration?', 'enlighten me.']

  intent 'quote', :quote
  route :quote, /^misc:quote$/i do
    respond_with(attachments: [quote]) do
      "Okay #{message.user_name}, here's an inspirational quote."
    end
  end

  private

  def quote
    quote = open('http://www.iheartquotes.com/api/v1/random').read
    quote = quote.gsub(/^\[[^\]]*\].*/, '').gsub(/(^\s+|\s+$)/m, '')
    quote = quote.gsub('&quot;', '"')
    {fallback: quote, text: quote, color: '#9ECCF9'}
  end

end
