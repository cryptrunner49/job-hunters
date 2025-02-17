require "application_system_test_case"

class JobOffersTest < ApplicationSystemTestCase
  setup do
    @job_offer = job_offers(:one)
  end

  test "visiting the index" do
    visit job_offers_url
    assert_selector "h1", text: "Job offers"
  end

  test "should create job offer" do
    visit job_offers_url
    click_on "New job offer"

    check "Apply from anywhere" if @job_offer.apply_from_anywhere
    fill_in "Closing date", with: @job_offer.closing_date
    fill_in "Company", with: @job_offer.company_id
    fill_in "Description", with: @job_offer.description
    fill_in "Employment type", with: @job_offer.employment_type
    fill_in "English level", with: @job_offer.english_level
    fill_in "Experience", with: @job_offer.experience
    fill_in "Japanese level", with: @job_offer.japanese_level
    fill_in "Location", with: @job_offer.location
    fill_in "Posted at", with: @job_offer.posted_at
    check "Relocation" if @job_offer.relocation
    fill_in "Remote", with: @job_offer.remote
    fill_in "Role", with: @job_offer.role_id
    fill_in "Salary", with: @job_offer.salary
    fill_in "Skills required", with: @job_offer.skills_required
    fill_in "Title", with: @job_offer.title
    click_on "Create Job offer"

    assert_text "Job offer was successfully created"
    click_on "Back"
  end

  test "should update Job offer" do
    visit job_offer_url(@job_offer)
    click_on "Edit this job offer", match: :first

    check "Apply from anywhere" if @job_offer.apply_from_anywhere
    fill_in "Closing date", with: @job_offer.closing_date.to_s
    fill_in "Company", with: @job_offer.company_id
    fill_in "Description", with: @job_offer.description
    fill_in "Employment type", with: @job_offer.employment_type
    fill_in "English level", with: @job_offer.english_level
    fill_in "Experience", with: @job_offer.experience
    fill_in "Japanese level", with: @job_offer.japanese_level
    fill_in "Location", with: @job_offer.location
    fill_in "Posted at", with: @job_offer.posted_at.to_s
    check "Relocation" if @job_offer.relocation
    fill_in "Remote", with: @job_offer.remote
    fill_in "Role", with: @job_offer.role_id
    fill_in "Salary", with: @job_offer.salary
    fill_in "Skills required", with: @job_offer.skills_required
    fill_in "Title", with: @job_offer.title
    click_on "Update Job offer"

    assert_text "Job offer was successfully updated"
    click_on "Back"
  end

  test "should destroy Job offer" do
    visit job_offer_url(@job_offer)
    click_on "Destroy this job offer", match: :first

    assert_text "Job offer was successfully destroyed"
  end
end
