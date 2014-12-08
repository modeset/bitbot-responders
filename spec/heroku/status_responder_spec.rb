require 'spec_helper'
require_relative('../../responders/heroku/status_responder')

describe StatusResponder do
  let(:message) { Bitbot::Message.new(text: text, user_name: 'archer') }

  describe 'status', vcr: true do
    let(:text) { 'heroku:status' }

    it 'responds with a status message' do
      response = subject.respond_to(message)
      expect(response[:text]).to eq("Heroku status as reported:")

      attachments = response[:attachments]
      expect(attachments.length).to eq(3)
      expect(attachments[0][:text]).to eq('Production: green')
      expect(attachments[1][:text]).to eq('Development: yellow')
      expect(attachments[2][:text]).to eq("(unresolved) Issues provisioning log drains -- <https://status.heroku.com/incidents/682|read more>\n")
    end

    describe 'with wit', vcr: true do
      let(:text) { 'status of heroku?' }

      it 'responds with a status message' do
        response = subject.respond_to(message)
        expect(response[:text]).to eq("Heroku status as reported:")
      end

    end
  end

  describe 'issues', vcr: true do
    let(:text) { 'heroku:issues' }

    it 'responds with the most recent 5 issues' do
      response = subject.respond_to(message)
      expect(response[:text]).to eq("Okay archer, here are the most recent Heroku issues:")

      attachments = response[:attachments]
      expect(attachments[0][:text]).to eq <<-MSG.strip_heredoc
        (resolved) Issues provisioning log drains -- <https://status.heroku.com/incidents/682|read more>
        (resolved) heroku.com to herokuapp.com redirect disabled -- <https://status.heroku.com/incidents/681|read more>
        (resolved) Potential Platform Issues -- <https://status.heroku.com/incidents/680|read more>
        (resolved) Scheduled Operational Update on October 23, 2014 at 23:00 UTC -- <https://status.heroku.com/incidents/679|read more>
        (resolved) POODLE SSL Vulnerability -- <https://status.heroku.com/incidents/678|read more>
      MSG
    end

    describe 'with wit', vcr: true do
      let(:text) { 'any issues with heroku?' }

      it 'responds with the most recent 5 issues' do
        response = subject.respond_to(message)
        expect(response[:text]).to eq("Okay archer, here are the most recent Heroku issues:")
      end

    end
  end
end
