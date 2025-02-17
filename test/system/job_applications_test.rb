require "application_system_test_case"

class JobApplicationsTest < ApplicationSystemTestCase
  setup do
    @job_application = job_applications(:one)
  end

  test "visiting the index" do
    visit job_applications_url
    assert_selector "h1", text: "Job applications"
  end

  test "should create job application" do
    visit job_applications_url
    click_on "New job application"

    fill_in "Applied at", with: @job_application.applied_at
    fill_in "Cover letter", with: @job_application.cover_letter_id
    fill_in "Feedback", with: @job_application.feedback
    fill_in "Hunter", with: @job_application.hunter_id
    fill_in "Job offer", with: @job_application.job_offer_id
    fill_in "Mail", with: @job_application.mail
    fill_in "Phase", with: @job_application.phase
    fill_in "Resume", with: @job_application.resume_id
    fill_in "Status", with: @job_application.status
    click_on "Create Job application"

    assert_text "Job application was successfully created"
    click_on "Back"
  end

  test "should update Job application" do
    visit job_application_url(@job_application)
    click_on "Edit this job application", match: :first

    fill_in "Applied at", with: @job_application.applied_at.to_s
    fill_in "Cover letter", with: @job_application.cover_letter_id
    fill_in "Feedback", with: @job_application.feedback
    fill_in "Hunter", with: @job_application.hunter_id
    fill_in "Job offer", with: @job_application.job_offer_id
    fill_in "Mail", with: @job_application.mail
    fill_in "Phase", with: @job_application.phase
    fill_in "Resume", with: @job_application.resume_id
    fill_in "Status", with: @job_application.status
    click_on "Update Job application"

    assert_text "Job application was successfully updated"
    click_on "Back"
  end

  test "should destroy Job application" do
    visit job_application_url(@job_application)
    click_on "Destroy this job application", match: :first

    assert_text "Job application was successfully destroyed"
  end
end
