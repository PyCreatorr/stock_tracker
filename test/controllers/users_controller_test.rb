require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get my_data" do
    get users_my_data_url
    assert_response :success
  end
end
