require "spec_helper"
require_relative("../../responders/misc/nickname_responder")

describe NicknameResponder do
  let(:message) { Bitbot::Message.new(text: text, user_name: "archer") }

  describe "nickname", vcr: true do
    describe "with an unknown world" do
      let(:text) { "misc:nickname pandora" }

      it "says it does not know that world" do
        expect { subject.respond_to(message) }.to raise_error(
          Bitbot::Response,
          %{I don't know of this "pandora" world.}
        )
      end
    end

    describe "with the pirate world" do
      let(:text) { "misc:nickname pirate" }

      it "responds with your nickname" do
        response = subject.respond_to(message)
        expect(response[:text]).to eq("Arrr! Yer pirate name be The Dread Pirate Swordfish")
      end
    end

    describe "with the wutang world" do
      let(:text) { "misc:nickname wutang" }

      it "responds with your nickname" do
        response = subject.respond_to(message)
        expect(response[:text]).to eq("Your Wu-Tang Clan name is Ruff Ambassador")
      end
    end

    describe "with the blues world" do
      let(:text) { "misc:nickname blues" }

      it "responds with your nickname" do
        response = subject.respond_to(message)
        expect(response[:text]).to eq("Welcome to the Crossroads, Blazin' Flatkeys")
      end
    end

    describe "with the potter world" do
      let(:text) { "misc:nickname potter" }

      it "responds with your nickname" do
        response = subject.respond_to(message)
        expect(response[:text]).to eq("Here is your wizarding name: Professor Crockford")
      end
    end

    describe "with the hacker world" do
      let(:text) { "misc:nickname hacker" }

      it "responds with your nickname" do
        response = subject.respond_to(message)
        expect(response[:text]).to eq("Welcome to the Matrix, archer f1r3wAll phr34k")
      end
    end

    describe "with wit", vcr: true do
      let(:text) { "what's my hacker nickname?" }

      it "responds with your nickname" do
        response = subject.respond_to(message)
        expect(response[:text]).to eq("Welcome to the Matrix, archer f1r3wAll phr34k")
      end
    end
  end
end
