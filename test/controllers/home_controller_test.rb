require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_post = job_posts(:one)
    @job_application = job_applications(:one)
  end

  test "should get index for unauthenticated user" do
    get root_url
    assert_response :success
    assert_select "h1", "Welcome to Job Hunters"
    assert_select "a[href=?]", new_session_path, text: "Sign In"
    assert_select "a[href=?]", new_hunter_path, text: "Sign Up"
  end

  test "should get index for authenticated user" do
    @hunter = hunters(:one)
    sign_in_as(@hunter, "password")
    assert_response :success
    assert_select "h1", "Welcome Back, #{@hunter.name}!"
    assert_select "a[href=?]", signout_path, text: "Sign Out"
    assert_select "h2", "Available Job Posts"
    assert_select "h2", "Your Job Applications"
  end
end
