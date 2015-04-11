require "spec_helper"
require_relative("../../../responders/general/standup_responder")

describe StandupResponder do
  let(:message) { Bitbot::Message.new(text: text, user_name: "archer", channel: "isis", channel_id: "42") }

  describe "adding standup" do
    let(:text) { "standup: working on something awesome." }
    let(:key) { "bitbot:standup:archer:isis:42:StandupResponder" }
    after do
      subject.connection.del(key)
    end

    it "tracks that task for that user" do
      response = subject.respond_to(message)
      expect(response).to be_falsey

      expect(subject.connection.get(key)).to include("working on something awesome.")
    end
  end

  describe "standup list" do
    let(:text) { "general:standup" }
    before do
      subject.respond_to(text: "standup: keeping Woodhouse in line.", user_name: "archer")
      subject.respond_to(text: "standup: spying on archer.", user_name: "lanakane")
    end

    it "displays a list of things people are working on" do
      response = subject.respond_to(message)
      expect(response[:text]).to eq("Okay @archer, here's what's going on:")

      fields = response[:attachments][0][:fields]
      expect(fields.length).to eq(2)
      expect(fields[0][:title]).to eq("archer")
      expect(fields[0][:value]).to eq("keeping Woodhouse in line.")
      expect(fields[1][:title]).to eq("lanakane")
      expect(fields[1][:value]).to eq("spying on archer.")
    end

    describe "with wit", vcr: true do
      let(:text) { "what is everyone working on today?" }

      it "displays a list of things people are working on" do
        response = subject.respond_to(message)
        expect(response[:text]).to eq("Okay @archer, here's what's going on:")
      end
    end

    describe "by username" do
      let(:text) { "general:standup archer" }

      it "displays a list of things that user is working on" do
        response = subject.respond_to(message)
        expect(response[:text]).to eq("Okay @archer, here's what's going on:")

        fields = response[:attachments][0][:fields]
        expect(fields.length).to eq(1)
        expect(fields[0][:title]).to eq("archer")
        expect(fields[0][:value]).to eq("keeping Woodhouse in line.")
      end

      describe "with wit", vcr: true do
        let(:text) { "what is archer working on today?" }

        it "displays a list of things that user is working on" do
          response = subject.respond_to(message)
          expect(response[:text]).to eq("Okay @archer, here's what's going on:")

          fields = response[:attachments][0][:fields]
          expect(fields.length).to eq(1)
        end
      end
    end
  end
end
