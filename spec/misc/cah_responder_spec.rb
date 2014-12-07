require 'spec_helper'
require_relative('../../responders/misc/cah_responder')

describe CardsAgainstHumanityResponder do
  let(:message) { Bitbot::Message.new(text: text, user_name: 'archer') }

  describe 'cards' do
    let(:text) { 'misc:cards' }
    before do
      allow(subject).to receive(:t).with('misc.cards_against_humanity.questions').and_return(['_____ + ___ = _______'])
      allow(subject).to receive(:t).with('misc.cards_against_humanity.answers').and_return(['_random_answer_'])
    end

    it 'responds with a random question and answer card' do
      response = subject.respond_to(message)
      expect(response[:text]).to eq('Okay @archer, here are your cards.')

      attachments = response[:attachments]
      expect(attachments[0][:text]).to eq('_____ + ___ = _______')
      expect(attachments[1][:text]).to eq('_random_answer_')
      expect(attachments[2][:text]).to eq('_random_answer_')
      expect(attachments[3][:text]).to eq('_random_answer_')
    end

    describe 'with wit', vcr: true do
      let(:text) { 'give me some cards.' }

      it 'responds with a random question and answer card' do
        response = subject.respond_to(message)
        expect(response[:text]).to eq('Okay @archer, here are your cards.')

        attachments = response[:attachments]
        expect(attachments[0][:text]).to eq('_____ + ___ = _______')
        expect(attachments[1][:text]).to eq('_random_answer_')
        expect(attachments[2][:text]).to eq('_random_answer_')
        expect(attachments[3][:text]).to eq('_random_answer_')
      end

    end
  end

  describe 'cards_question' do
    let(:text) { 'misc:cards:question' }
    before do
      allow(subject).to receive(:t).with('misc.cards_against_humanity.questions').and_return(['_random_question_'])
    end

    it 'responds with a random question card' do
      response = subject.respond_to(message)
      expect(response[:text]).to eq("Okay @archer, here's your question card.")

      attachments = response[:attachments]
      expect(attachments[0][:text]).to eq('_random_question_')
    end

  end

  describe 'cards_answer' do
    let(:text) { 'misc:cards:answer' }
    before do
      allow(subject).to receive(:t).with('misc.cards_against_humanity.answers').and_return(['_random_answer_'])
    end

    it 'responds with a random answer card' do
      response = subject.respond_to(message)
      expect(response[:text]).to eq("Okay @archer, here's your answer card.")

      attachments = response[:attachments]
      expect(attachments[0][:text]).to eq('_random_answer_')
    end

  end

end
