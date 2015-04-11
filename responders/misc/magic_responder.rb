class MagicResponder < Bitbot::Responder
  include Bitbot::Responder::Wit

  category "Miscellaneous"

  help "misc:magic8ball",
       description: "Ask the almighty 8-ball for an answer to your question",
       examples: ["8ball me.", "magic 8 ball says?"]

  intent "magic8ball", :magic8ball

  route :magic8ball, /^misc:magic8ball$/i do
    respond_with <<-MSG.strip_heredoc
      :8ball: #{message.user_name}, #{t('misc.magic.responses').sample}
    MSG
  end
end
