require 'test_helper'

class Admins::AnswersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_answers_index_url
    assert_response :success
  end

  test "should get show" do
    get admins_answers_show_url
    assert_response :success
  end

  test "should get destroy" do
    get admins_answers_destroy_url
    assert_response :success
  end
end
