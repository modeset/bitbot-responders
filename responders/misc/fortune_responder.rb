class FortuneResponder < Bitbot::Responder
  include Bitbot::Responder::Wit

  category 'Miscellaneous'
  help 'misc:fortune',
       description: 'Reaches into the worlds aura and spirit to provide a fortune',
       examples: ['fortune me.', 'what\'s my fortune?', 'give me a fortune cookie.']

  intent 'fortune', :fortune

  route :fortune, /^misc:fortune$/i do
    fortune = t('misc.fortune.responses').sample

    respond_with <<-MSG.strip_heredoc
      :crystal_ball: #{message.user_name}, #{fortune}#{rand(10) < 3 ? '.. In bed.' : ''}
    MSG
  end

end
