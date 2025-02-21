require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_post = job_posts(:one)
    @job_application = job_applications(:one)
    @hunter = hunters(:one)
  end

  test "should get index for unauthenticated user" do
    get root_url
    assert_response :success
    assert_select "h1", "Welcome to Job Hunters"
    assert_select "a[href=?]", new_session_path, text: "Sign In"
    assert_select "a[href=?]", new_hunter_path, text: "Sign Up"
  end

  test "should get index for authenticated user" do
    sign_in_as(@hunter.email_address, "password")
    get root_url
    assert_response :success
    assert_select "h1", "Welcome Back, #{@hunter.name}!"
    assert_select "a[href=?]", sign_out_path, text: "Sign Out"
    assert_select ".grid .bg-white, .grid .dark\\:bg-gray-800" # Job posts grid
    assert_select "ul.divide-y li" # Applications list
  end
end
