require 'test_helper'

class Public::RelationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_relations_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_relations_destroy_url
    assert_response :success
  end

end
