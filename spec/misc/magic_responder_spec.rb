require "spec_helper"
require_relative("../../responders/misc/magic_responder")

describe MagicResponder do
  let(:message) { Bitbot::Message.new(text: text, user_name: "archer") }

  describe "magic8ball" do
    let(:text) { "misc:magic8ball" }
    before do
      expect(subject).to receive(:t).with("misc.magic.responses").and_return(["_random_response_"])
    end

    it "responds with a random response" do
      response = subject.respond_to(message)
      expect(response[:text]).to eq(":8ball: archer, _random_response_\n")
    end

    describe "with wit", vcr: true do
      let(:text) { "what's the 8 ball say about me getting laid tonight?" }

      it "responds with a random response" do
        response = subject.respond_to(message)
        expect(response[:text]).to eq(":8ball: archer, _random_response_\n")
      end
    end
  end
end
