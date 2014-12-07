require 'spec_helper'
require_relative('../../responders/general/timer_responder')

describe TimerResponder do
  let(:message) { Bitbot::Message.new(text: text, user_name: 'archer') }

  describe 'timer' do
    let(:text) { 'general:timer 62' }
    before do
      allow(subject).to receive(:delay).and_yield
      allow(subject).to receive(:announce)
    end

    it 'responds with a message' do
      response = subject.respond_to(message)
      expect(response[:text]).to include("Okay @archer, I've set a timer for 1 minute 2 seconds.\n")
    end

    it 'delays a response back' do
      subject.respond_to(message)
      expect(subject).to have_received(:delay).with(62)
      expect(subject).to have_received(:announce).with(":alarm_clock: Okay, @archer your timer's done.\n")
    end

    describe 'with wit', vcr: true do
      let(:text) { 'set a timer for 20 minutes' }

      it 'responds with a message' do
        response = subject.respond_to(message)
        expect(response[:text]).to include("Okay @archer, I've set a timer for 20 minutes.\n")
      end

    end
  end
end
