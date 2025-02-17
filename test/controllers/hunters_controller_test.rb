require "test_helper"

class HuntersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_hunter_url  # Use new_user_url instead of users_new_url
    assert_response :success
  end

  test "should get create" do
    get signup_path  # Use users_url with POST instead of users_create_url
    assert_response :success
  end
end
