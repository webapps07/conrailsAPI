require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @feedback = feedbacks(:one)
  end

  test "should get index" do
    get feedbacks_url, as: :json
    assert_response :success
  end

  test "should create feedback" do
    assert_difference('Feedback.count') do
      post feedbacks_url, params: { feedback: { agree: @feedback.agree, contacttype: @feedback.contacttype, email: @feedback.email, firstname: @feedback.firstname, lastname: @feedback.lastname, message: @feedback.message, telnum: @feedback.telnum } }, as: :json
    end

    assert_response 201
  end

  test "should show feedback" do
    get feedback_url(@feedback), as: :json
    assert_response :success
  end

  test "should update feedback" do
    patch feedback_url(@feedback), params: { feedback: { agree: @feedback.agree, contacttype: @feedback.contacttype, email: @feedback.email, firstname: @feedback.firstname, lastname: @feedback.lastname, message: @feedback.message, telnum: @feedback.telnum } }, as: :json
    assert_response 200
  end

  test "should destroy feedback" do
    assert_difference('Feedback.count', -1) do
      delete feedback_url(@feedback), as: :json
    end

    assert_response 204
  end
end
