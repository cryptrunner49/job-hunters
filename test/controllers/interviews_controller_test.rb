require "test_helper"

class InterviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_application = job_applications(:one)
    @interview = interviews(:one)
    @hunter = hunters(:one)
    sign_in_as(@hunter.email_address, "password")
  end

  test "should get new" do
    get new_job_application_interview_url(@job_application)
    assert_response :success
  end

  test "should create interview" do
    assert_difference("Interview.count") do
      post job_application_interviews_url(@job_application), params: { interview: { interview_type: @interview.interview_type, job_application_id: @job_application.id, mode: @interview.mode, notes: @interview.notes, result: @interview.result, scheduled_date: @interview.scheduled_date } }
    end

    assert_redirected_to job_application_interview_url(@job_application, Interview.last)
  end

  test "should show interview" do
    get job_application_interview_url(@job_application, @interview)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_application_interview_url(@job_application, @interview)
    assert_response :success
  end

  test "should update interview" do
    patch job_application_interview_url(@job_application, @interview), params: { interview: { interview_type: @interview.interview_type, job_application_id: @job_application.id, mode: @interview.mode, notes: @interview.notes, result: @interview.result, scheduled_date: @interview.scheduled_date } }
    assert_redirected_to job_application_interview_url(@job_application, @interview)
  end

  test "should destroy interview" do
    assert_no_difference("Interview.count") do
      delete job_application_interview_url(@job_application, @interview)
    end

    @interview.reload
    assert @interview.deleted
    assert_redirected_to job_application_interviews_url(@job_application)
  end
end
