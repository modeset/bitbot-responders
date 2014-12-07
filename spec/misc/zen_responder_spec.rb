require 'spec_helper'
require_relative('../../responders/misc/zen_responder')

describe ZenResponder do
  let(:message) { Bitbot::Message.new(text: text, user_name: 'archer') }

  describe 'zen', vcr: true do
    let(:text) { 'misc:zen' }

    it 'responds with a zen message' do
      response = subject.respond_to(message)
      expect(response[:text]).to eq("archer, Favor focus over features.")
    end

    describe 'with wit', vcr: true do
      let(:text) { 'give me some zen.' }

      it 'responds with a zen message' do
        response = subject.respond_to(message)
        expect(response[:text]).to eq("archer, Avoid administrative distraction.")
      end

    end
  end
end
