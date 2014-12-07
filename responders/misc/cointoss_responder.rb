class CointossResponder < Bitbot::Responder
  include Bitbot::Responder::Wit

  category 'Miscellaneous'
  help 'misc:cointoss', description: 'Flips a coin and provides the result',
    examples: ["heads or tails?", "flip a coin.", "coin toss."]

  intent 'cointoss', :cointoss
  route :cointoss, /^misc:cointoss$/i do
    respond_with <<-MSG.strip_heredoc
      #{t('misc.cointoss.responses').sample}
    MSG
  end

end
