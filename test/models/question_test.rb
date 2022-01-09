require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test 'cannot vote ended question' do
    freeze_time # So Time.now returns consistent result.
    question = Question.create(question_text: 'rsrt', end_date: Time.now + 10.days)
    assert question.can_vote
    travel_to Time.now + 11.days
    assert(!question.can_vote)
  end
end
