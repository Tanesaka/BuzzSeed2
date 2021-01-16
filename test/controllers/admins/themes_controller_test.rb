require 'test_helper'

class Admins::ThemesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_themes_index_url
    assert_response :success
  end

  test "should get destroy" do
    get admins_themes_destroy_url
    assert_response :success
  end
end
