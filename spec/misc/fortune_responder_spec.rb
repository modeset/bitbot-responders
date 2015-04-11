require "spec_helper"
require_relative("../../responders/misc/fortune_responder")

describe FortuneResponder do
  let(:message) { Bitbot::Message.new(text: text, user_name: "archer") }

  describe "fortune" do
    let(:text) { "misc:fortune" }
    before do
      allow(subject).to receive(:t).with("misc.fortune.responses").and_return(["_random_response_"])
      allow(subject).to receive(:rand).with(10).and_return(9)
    end

    it "responds with a random fortune" do
      response = subject.respond_to(message)
      expect(response[:text]).to eq(":crystal_ball: archer, _random_response_\n")
    end

    it "can be sultry" do
      allow(subject).to receive(:rand).with(10).and_return(2)

      response = subject.respond_to(message)
      expect(response[:text]).to eq(":crystal_ball: archer, _random_response_.. In bed.\n")
    end

    describe "with wit", vcr: true do
      let(:text) { "my fortune for the day?" }

      it "responds with a random fortune" do
        response = subject.respond_to(message)
        expect(response[:text]).to eq(":crystal_ball: archer, _random_response_\n")
      end
    end
  end
end
