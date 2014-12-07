class CardsAgainstHumanityResponder < Bitbot::Responder
  include Bitbot::Responder::Wit

  category 'Cards Against Humanity'
  help 'misc:cards', description: 'Provides a random question and answer card.',
    examples: ['cards against humanity.', 'give me some cards.']

  intent 'cah_cards', :cards
  route :cards, /^misc:cards$/i do
    question = question_card
    respond_with(attachments: [question, answer_cards_for(question)].flatten) do
      "Okay @#{message.user_name}, here are your cards."
    end
  end

  route :cards_question, /^misc:cards:question$/i do
    respond_with(attachments: [question_card]) do
      "Okay @#{message.user_name}, here's your question card."
    end
  end

  route :cards_answer, /^misc:cards:answer$/i do
    respond_with(attachments: [answer_card]) do
      "Okay @#{message.user_name}, here's your answer card."
    end
  end

  private

  def question_card
    question = t('misc.cards_against_humanity.questions').sample
    {fallback: question, text: question, color: '#000000'}
  end

  def answer_card
    answer = t('misc.cards_against_humanity.answers').sample
    {fallback: answer, text: answer, color: '#EEEEEE'}
  end

  def answer_cards_for(question)
    matches = question[:text].scan(/([_]+)/)
    matches = ['_____'] if matches.empty?
    matches.map { answer_card }
  end

end
