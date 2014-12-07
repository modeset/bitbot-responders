# encoding: UTF-8
require 'open-uri'

class QuoteResponder < Bitbot::Responder
  include Bitbot::Responder::Wit

  category 'Miscellaneous'
  help 'misc:achievement username <text>', description: 'Displays the achievement award to the user',
    examples: ['give @jejacks0n a badge for "Being Awesome."', '@cacheflowe deserves a "Participation" achievement.']

  intent 'achievement', :achievement, entities: {slack_user_id: nil, message_subject: nil}
  route :achievement, /^misc:achievement ([^\s]+) (.*)$/i do |user, award|
    raise(Bitbot::Response, "No user or achievement provided") if user.to_s.empty? || award.to_s.empty?
    email = Bitbot::RestClient::Users.info(user)['user']['profile']['email']
    award = CGI.escape(award.to_s).gsub(/\+|\s/, '%20')

    link = "<http://achievement-unlocked.herokuapp.com/xbox/#{award}.png?email=#{email}|achievement>"
    respond_with(unfurl_links: true, parse: 'none') do
      "#{user}! Congratulations on your #{link}"
    end
  end

end
