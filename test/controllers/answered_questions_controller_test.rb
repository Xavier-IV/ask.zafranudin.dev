require "test_helper"

class AnsweredQuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get answered_questions_index_url
    assert_response :success
  end

  test "should get show" do
    get answered_questions_show_url
    assert_response :success
  end
end
