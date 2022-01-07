require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test 'cannot vote ended question' do
    freeze_time # So Time.now returns consistent result.
    past_question = Question.new(end_date: Time.now - 1.days)
    future_question = Question.new(end_date: Time.now + 1.days)
    current_question = Question.new(end_date: Time.now)

    assert(!past_question.can_vote)
    assert future_question.can_vote
    assert current_question.can_vote
  end
end
