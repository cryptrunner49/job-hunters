require "test_helper"

class ResumesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resume = resumes(:one)
    @hunter = hunters(:one)
    sign_in_as(@hunter.email_address, "password")
  end

  test "should get index" do
    get resumes_url
    assert_response :success
  end

  test "should get new" do
    get new_resume_url
    assert_response :success
  end

  test "should create resume" do
    assert_difference("Resume.count") do
      post resumes_url, params: { resume: { title: "Unique Title", resume_type: @resume.resume_type, latex_source: @resume.latex_source } }
    end

    assert_redirected_to resume_url(Resume.last)
  end

  test "should show resume" do
    get resume_url(@resume)
    assert_response :success
  end

  test "should get edit" do
    get edit_resume_url(@resume)
    assert_response :success
  end

  test "should update resume" do
    patch resume_url(@resume),
          params: { resume: { title: "Updated Title" } }
    assert_redirected_to resume_url(@resume)
  end

  test "should destroy resume" do
    assert_no_difference("Resume.count") do
      delete resume_url(@resume)
    end
    @resume.reload
  end
end
