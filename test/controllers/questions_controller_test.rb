require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @past_question = questions(:past_question)
    @future_question = questions(:future_question)
  end

  test 'should get index' do
    get questions_url
    assert_response :success
  end

  test 'should get result' do
    get result_url(@past_question)
    assert_response :success
  end

  test 'should show the question that is not ended in the detail' do
    get question_url(@future_question)
    assert_response :success
  end

  test 'should show voting when question is available' do
    get question_url(@past_question)
    assert_response :redirect
    assert_redirected_to result_url(@past_question)
  end

  test 'should be able to vote when the question is available' do
    assert_difference('@future_question.choices.first.votes', 1) do
      post vote_url(@future_question), params: { choice_id: @future_question.choices.first.id }
    end
    assert_redirected_to result_url(@future_question)
  end

  #   assert_difference('Question.count') do
  #     post questions_url, params: { question: { description: @question.description, question_text: @question.question_text } }
  #   end

  #   assert_redirected_to question_url(Question.last)
  # end

  # test "should show question" do
  #   get question_url(@question)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_question_url(@question)
  #   assert_response :success
  # end

  # test "should update question" do
  #   patch question_url(@question), params: { question: { description: @question.description, question_text: @question.question_text } }
  #   assert_redirected_to question_url(@question)
  # end

  # test "should destroy question" do
  #   assert_difference('Question.count', -1) do
  #     delete question_url(@question)
  #   end

  #   assert_redirected_to questions_url
  # end
end
