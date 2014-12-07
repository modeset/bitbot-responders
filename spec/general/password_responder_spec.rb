require 'spec_helper'
require_relative('../../responders/general/password_responder')

describe PasswordResponder, vcr: true do
  let(:message) { Bitbot::Message.new(text: text, user_name: 'archer') }

  describe 'password' do
    let(:text) { 'general:password 22' }

    it 'responds with a password' do
      response = subject.respond_to(message)
      expect(response[:text]).to include(":lock: Okay @archer, here's a password: otwaububao6fitesarteag\n")
    end

    describe 'with wit', vcr: true do
      let(:text) { 'I need a password 32 characters long.' }

      it 'responds with a message' do
        response = subject.respond_to(message)
        expect(response[:text]).to include(":lock: Okay @archer, here's a password: gauyu1ngaradacihievureowew4rawhe\n")
      end

    end
  end
end
