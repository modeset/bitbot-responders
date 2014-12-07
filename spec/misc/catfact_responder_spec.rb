require 'spec_helper'
require_relative('../../responders/misc/catfact_responder')

describe CatfactResponder do
  let(:message) { Bitbot::Message.new(text: text, user_name: 'archer') }

  describe 'catfact' do
    let(:text) { 'misc:catfact' }
    before do
      allow(subject).to receive(:t).with('misc.catfact.responses').and_return(['_random_response_'])
    end

    it 'responds with a random cat fact' do
      response = subject.respond_to(message)
      expect(response[:text]).to eq(":cat: CAT FACT _random_response_\n")
    end

    describe 'with wit', vcr: true do
      let(:text) { 'I hate cats' }

      it 'responds with a random cat fact' do
        response = subject.respond_to(message)
        expect(response[:text]).to eq(":cat: CAT FACT _random_response_\n")
      end

    end
  end
end
