require "spec_helper"
require_relative("../../responders/misc/quote_responder")

describe QuoteResponder do
  let(:message) { Bitbot::Message.new(text: text, user_name: "archer") }

  describe "quote", vcr: true do
    let(:text) { "misc:quote" }

    it "responds with a quote" do
      response = subject.respond_to(message)
      expect(response[:text]).to eq("Okay archer, here's an inspirational quote.")

      attachments = response[:attachments]
      expect(attachments[0][:text]).to eq("Be it our wealth, our jobs, or even our homes; nothing is safe while the\nlegislature is in session.")
    end

    describe "with wit", vcr: true do
      let(:text) { "give me a quote." }

      it "responds with a quote" do
        response = subject.respond_to(message)
        expect(response[:text]).to eq("Okay archer, here's an inspirational quote.")
      end
    end
  end
end
