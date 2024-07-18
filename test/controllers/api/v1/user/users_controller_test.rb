require "test_helper"

class Api::V1::User::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_user_users_index_url
    assert_response :success
  end
end
