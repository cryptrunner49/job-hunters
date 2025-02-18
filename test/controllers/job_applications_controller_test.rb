require "test_helper"

class JobApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_application = job_applications(:one)
    @hunter = hunters(:one)
    sign_in_as(@hunter, "password")
  end

  test "should get index" do
    get job_applications_url
    assert_response :success
  end

  test "should get new" do
    get new_job_application_url
    assert_response :success
  end

  test "should create job_application" do
    assert_difference("JobApplication.count") do
      post job_applications_url, params: { job_application: { applied_at: @job_application.applied_at, cover_letter_id: @job_application.cover_letter_id, feedback: @job_application.feedback, hunter_id: @job_application.hunter_id, job_post_id: @job_application.job_post_id, mail: @job_application.mail, phase: @job_application.phase, resume_id: @job_application.resume_id, status: @job_application.status } }
    end

    assert_redirected_to job_application_url(JobApplication.last)
  end

  test "should show job_application" do
    get job_application_url(@job_application)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_application_url(@job_application)
    assert_response :success
  end

  test "should update job_application" do
    patch job_application_url(@job_application), params: { job_application: { applied_at: @job_application.applied_at, cover_letter_id: @job_application.cover_letter_id, feedback: @job_application.feedback, hunter_id: @job_application.hunter_id, job_post_id: @job_application.job_post_id, mail: @job_application.mail, phase: @job_application.phase, resume_id: @job_application.resume_id, status: @job_application.status } }
    assert_redirected_to job_application_url(@job_application)
  end

  test "should destroy job_application" do
    assert_no_difference("JobApplication.count") do
      delete job_applications_url(@job_application)
    end

    @job_application.reload
    assert @job_application.deleted
    assert_redirected_to job_applications_url
  end

  private

  def sign_in_as(hunter, password)
    post session_url, params: { email_address: hunter.email_address, password: password }
  end
end
