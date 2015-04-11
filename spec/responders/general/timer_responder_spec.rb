require "spec_helper"
require_relative("../../../responders/general/timer_responder")

describe TimerResponder do
  let(:message) { Bitbot::Message.new(text: text, user_name: "archer") }

  describe "timer" do
    let(:text) { "general:timer #{@seconds || 62}" }
    before do
      allow(Time).to receive(:now).and_return(Time.parse("10/10/2012 0:00:00"))
      allow(subject).to receive(:delay).and_yield
      allow(subject).to receive(:announce)
    end

    it "responds with a message" do
      @seconds = 60 * 10 + 20
      response = subject.respond_to(message)
      expect(response[:text]).to include("Okay @archer, I've set a timer for 10 minutes 20 seconds.\n")
    end

    it "handles minutes and seconds" do
      @seconds = 60 * 50 + 20
      response = subject.respond_to(message)
      expect(response[:text]).to include("Okay @archer, I've set a timer for 50 minutes 20 seconds.\n")
    end

    it "handles hours" do
      @seconds = 60 * 90 + 20
      response = subject.respond_to(message)
      expect(response[:text]).to include("Okay @archer, I've set a timer for 1 hour 30 minutes 20 seconds.\n")
    end

    it "delays a response back" do
      @seconds = 60 * 40 + 20
      subject.respond_to(message)
      expect(subject).to have_received(:delay).with(2420)
      expect(subject).to have_received(:announce).with(":alarm_clock: Okay, @archer your timer's done.\n")
    end

    describe "with wit", vcr: true do
      let(:text) { "set a timer for 20 minutes" }

      it "responds with a message" do
        response = subject.respond_to(message)
        expect(response[:text]).to include("Okay @archer, I've set a timer for 20 minutes.\n")
      end
    end
  end
end
