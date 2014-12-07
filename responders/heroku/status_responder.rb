# encoding: UTF-8
require 'open-uri'

class StatusResponder < Bitbot::Responder
  include Bitbot::Responder::Wit

  category 'Heroku'
  help 'heroku:status', description: 'Returns the current Heroku status for app operations and tools',
    examples: ['heroku status?', 'what\'s the status of heroku?']
  help 'heroku:issues', description: 'Returns a list of the most recent 5 issues',
    examples: ['heroku issues?', 'is heroku reporting any issues?']

  intent 'heroku_status', :heroku_status
  route :heroku_status, /^heroku:status$/i do
    respond_with(text: 'Heroku status:', attachments: status_attachments, parse: 'none')
  end

  intent 'heroku_issues', :heroku_issues
  route :heroku_issues, /^heroku:issues/i do
    respond_with(attachments: [issue_attachment], parse: 'none') do
      "Okay #{message.user_name}, here are the most recent Heroku issues:"
    end
  end

  private

  def status_attachments
    info = JSON.parse(open('https://status.heroku.com/api/v3/current-status').read)
    status = info['status']
    platforms = ['Production', 'Development'].map do |platform|
      {fallback: "#{platform}: #{status[platform]}", text: "#{platform}: #{status[platform]}", color: color_for(status[platform])}
    end
    platforms + [issue_attachment(info['issues'])]
  end

  def issue_attachment(issues = nil)
    issues ||= JSON.parse(open('https://status.heroku.com/api/v3/issues?limit=5').read)
    text = issues.map { |i| "#{i['resolved'] ? '(resolved)' : '(unresolved)'} #{i['title']} -- <#{i['full_url']}|read more>\n" }
    {fallback: text.join(''), text: text.join('')}
  end

  def color_for(status)
    case status
      when 'red' then '#FF0000'
      when 'yellow' then '#FFD000'
      when 'green' then '#00FF00'
    end
  end

end
