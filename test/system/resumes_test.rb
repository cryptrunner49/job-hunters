require "application_system_test_case"

class ResumesTest < ApplicationSystemTestCase
  setup do
    @resume = resumes(:one)
  end

  test "visiting the index" do
    visit resumes_url
    assert_selector "h1", text: "Resumes"
  end

  test "should create resume" do
    visit resumes_url
    click_on "New resume"

    fill_in "Hunter", with: @resume.hunter_id
    fill_in "Latex source", with: @resume.latex_source
    fill_in "Pdf path", with: @resume.pdf_path
    fill_in "Resume type", with: @resume.resume_type
    fill_in "Title", with: @resume.title
    click_on "Create Resume"

    assert_text "Resume was successfully created"
    click_on "Back"
  end

  test "should update Resume" do
    visit resume_url(@resume)
    click_on "Edit this resume", match: :first

    fill_in "Hunter", with: @resume.hunter_id
    fill_in "Latex source", with: @resume.latex_source
    fill_in "Pdf path", with: @resume.pdf_path
    fill_in "Resume type", with: @resume.resume_type
    fill_in "Title", with: @resume.title
    click_on "Update Resume"

    assert_text "Resume was successfully updated"
    click_on "Back"
  end

  test "should destroy Resume" do
    visit resume_url(@resume)
    click_on "Destroy this resume", match: :first

    assert_text "Resume was successfully destroyed"
  end
end
