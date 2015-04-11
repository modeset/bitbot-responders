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

    it "handles when the site is down" do
      response = subject.respond_to(message)
      expect(response[:text]).to eq(":no_entry: @archer, ello.co looks DOWN from here.\n")
    end

    it "handles when domain wasn't found" do
      response = subject.respond_to(message)
      expect(response[:text]).to eq(":warning: @archer, are you sure ello.co is a valid domain?.\n")
    end

    it "handles errors in trying to check" do
      response = subject.respond_to(message)
      expect(response[:text]).to eq("@archer, I'm unsure about ello.co, there was an error looking it up.\n")
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
