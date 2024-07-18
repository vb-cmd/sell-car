require "test_helper"

class Api::V1::BaseControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_base_index_url
    assert_response :success
  end
end
