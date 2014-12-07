require 'open-uri'

class PasswordResponder < Bitbot::Responder
  include Bitbot::Responder::Wit

  category 'General'
  help 'general:password <length>', description: 'Generates a readable password',
    examples: ['I need a password.', 'generate a password for me.']

  intent 'password', :password, entities: { number: nil }
  route :password, /^general:password\s?(\d+)?$/i do |length|
    length ||= 32
    length = length.to_i

    password = open("https://passwd.me/api/1.0/get_password.txt?type=pronounceable&length=#{length}&charset=LOWERCASEALPHANUMERIC").read

    respond_with <<-MSG.strip_heredoc
      :lock: Okay @#{message.user_name}, here's a password: #{password}
    MSG
  end

end
