require 'open-uri'

class IsItUpResponder < Bitbot::Responder
  include Bitbot::Responder::Wit

  SERVICE = 'http://isitup.org'

  category 'General'

  help 'general:isitup <domain>',
       description: 'Checks to see if a domain is up.',
       examples: ['is ello.co up?', 'is ello.co down?']

  intent 'isitup', :isitup, entities: { url: nil }

  route :isitup, /^general:isitup\s+(.*)$/i do |domain|
    domain = domain.split('|')[0].gsub(/http:\/\//i, '')
    status = JSON.parse(open("#{SERVICE}/#{CGI.escape(domain)}.json").read)
    icon, status = status_from(domain, status['status_code'])

    respond_with <<-MSG.strip_heredoc
      #{icon}@#{message.user_name}, #{status}
    MSG
  end

  private

  def status_from(domain, status_code)
    case status_code
    when 1 then [':white_check_mark: ', "#{domain} looks UP from here."]
    when 2 then [':no_entry: ', "#{domain} looks DOWN from here."]
    when 3 then [':warning: ', "are you sure #{domain} is a valid domain?."]
    else ['', "I'm unsure about #{domain}, there was an error looking it up."]
    end
  end

end
