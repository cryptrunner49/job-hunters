require "test_helper"

class HuntersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_hunter_url  # Use new_hunter_url instead of hunters_new_url
    assert_response :success
  end

  test "should create hunter" do
    post signup_path, params: { hunter: { name: "Test Hunter", email_address: "testhunter@example.com", password: "password", password_confirmation: "password" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match "Account created successfully!", flash[:notice]
  end
end
