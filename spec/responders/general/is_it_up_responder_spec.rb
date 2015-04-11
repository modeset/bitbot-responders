require "spec_helper"
require_relative("../../../responders/general/is_it_up_responder")

describe IsItUpResponder do
  let(:message) { Bitbot::Message.new(text: text, user_name: "archer") }

  describe "isitup", vcr: true do
    let(:text) { "general:isitup http://ello.co|ello.co>" }

    it "responds with the status" do
      response = subject.respond_to(message)
      expect(response[:text]).to eq(":white_check_mark: @archer, ello.co looks UP from here.\n")
    end

    describe "with wit", vcr: true do
      let(:text) { "is ello.co up?" }

      it "responds with the status" do
        response = subject.respond_to(message)
        expect(response[:text]).to eq(":white_check_mark: @archer, ello.co looks UP from here.\n")
      end
    end
  end
end
