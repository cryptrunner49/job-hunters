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
end
