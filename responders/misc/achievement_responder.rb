# encoding: UTF-8
require 'open-uri'

class QuoteResponder < Bitbot::Responder
  include Bitbot::Responder::Wit

  SERVICE = 'http://achievement-unlocked.herokuapp.com'

  category 'Miscellaneous'

  help 'misc:achievement username <text>',
       description: 'Displays the achievement award to the user',
       examples: [
         'give @jejacks0n a badge for "Being Awesome."',
         '@cacheflowe deserves a "Participation" achievement.'
       ]

  intent 'achievement', :achievement, entities: {slack_user_id: nil, message_subject: nil}

  route :achievement, /^misc:achievement ([^\s]+) (.*)$/i do |user, award|
    if user.to_s.empty? || award.to_s.empty?
      raise(Bitbot::Response, 'No user or achievement provided')
    end

    email = Bitbot::RestClient::Users.info(user)['user']['profile']['email']
    award = CGI.escape(award.to_s).gsub(/\+|\s/, '%20')

    link = "<#{SERVICE}/xbox/#{award}.png?email=#{email}|achievement>"
    respond_with(unfurl_links: true, parse: 'none') do
      "#{user}! Congratulations on your #{link}"
    end
  end

end
