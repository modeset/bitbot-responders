class CatfactResponder < Bitbot::Responder
  include Bitbot::Responder::Wit

  category 'Miscellaneous'
  help 'misc:catfact', description: 'Provides a random cat fact from my massive trivia database',
    examples: ['cat fact?', 'I hate cats.', 'what should I know about cats?']

  intent 'catfact', :catfact
  route :catfact, /^misc:catfact$/i do
    respond_with <<-MSG.strip_heredoc
      :cat: CAT FACT #{t('misc.catfact.responses').sample}
    MSG
  end

end
