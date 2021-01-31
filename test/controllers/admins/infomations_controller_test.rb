require 'test_helper'

class Admins::InfomationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admins_infomations_new_url
    assert_response :success
  end

  test "should get create" do
    get admins_infomations_create_url
    assert_response :success
  end

  test "should get destroy" do
    get admins_infomations_destroy_url
    assert_response :success
  end

  test "should get index" do
    get admins_infomations_index_url
    assert_response :success
  end

end
