require 'test_helper'

class Public::ImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_images_new_url
    assert_response :success
  end

  test "should get create" do
    get public_images_create_url
    assert_response :success
  end

  test "should get show" do
    get public_images_show_url
    assert_response :success
  end

  test "should get index" do
    get public_images_index_url
    assert_response :success
  end
end
