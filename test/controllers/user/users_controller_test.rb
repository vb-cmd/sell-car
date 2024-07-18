require "test_helper"

class User::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_users_index_url
    assert_response :success
  end
end
