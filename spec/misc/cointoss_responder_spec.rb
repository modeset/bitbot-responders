require 'spec_helper'
require_relative('../../responders/misc/cointoss_responder')

describe CointossResponder do
  let(:message) { Bitbot::Message.new(text: text, user_name: 'archer') }

  describe 'cointoss' do
    let(:text) { 'misc:cointoss' }
    before do
      allow(subject).to receive(:t).with('misc.cointoss.responses').and_return(['_heads_'])
    end

    it 'responds with a random heads or tails' do
      response = subject.respond_to(message)
      expect(response[:text]).to eq("_heads_\n")
    end

    describe 'with wit', vcr: true do
      let(:text) { 'flip a coin for me.' }

      it 'responds with a random heads or tails' do
        response = subject.respond_to(message)
        expect(response[:text]).to eq("_heads_\n")
      end

    end
  end
end
