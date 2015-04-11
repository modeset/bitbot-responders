# encoding: UTF-8
require "open-uri"

class ZenResponder < Bitbot::Responder
  include Bitbot::Responder::Wit

  SERVICE = "https://api.github.com/zen"

  category "Miscellaneous"

  help "misc:zen",
       description: "Responds with a zen message",
       examples: ["give me zen.", "zen me."]

  intent "zen", :zen

  route :zen, /^misc:zen$/i do
    respond_with("#{message.user_name}, #{open(SERVICE).read}")
  end
end
