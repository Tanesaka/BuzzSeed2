require 'test_helper'

class Public::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_reviews_index_url
    assert_response :success
  end

end
