require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @past_question = questions(:past_question)
    @future_question = questions(:future_question)
    @user = users(:one)
  end

  # Vote on the question with choice_id
  def vote(question, choice_id)
    post vote_url(question), params: { choice_id: choice_id }
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

  test 'should not be able to vote ended question' do
    sign_in @user
    get question_url(@past_question)
    assert_redirected_to result_url(@past_question)
  end

  test 'should be able to vote when the question is available' do
    sign_in @user
    assert_difference('@future_question.choices.first.votes.reload.count') do
      post vote_url(@future_question), params: { choice_id: @future_question.choices.first.id }
    end
    assert_redirected_to result_url(@future_question)
  end

  test 'should not be able to vote when not signed in' do
    vote(@future_question, @future_question.choices.first.id)
    assert_redirected_to new_user_session_url
  end

  test 'each vote should be unique' do
    sign_in @user
    vote(@future_question, @future_question.choices.first.id)
    # Vote it twice
    vote(@future_question, @future_question.choices.second.id)
    vote(@future_question, @future_question.choices.second.id)
    assert_equal @future_question.choices.first.votes.reload.count, 0
    assert_equal @future_question.choices.second.votes.reload.count, 1
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
