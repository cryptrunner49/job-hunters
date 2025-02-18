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

    fill_in "Company", with: @job_offer.company_id
    fill_in "Hunter", with: @job_offer.hunter_id
    fill_in "Job post", with: @job_offer.job_post_id
    fill_in "Message", with: @job_offer.message
    fill_in "Offer date", with: @job_offer.offer_date
    fill_in "Salary", with: @job_offer.salary
    fill_in "Start date", with: @job_offer.start_date
    fill_in "Status", with: @job_offer.status
    click_on "Create Job offer"

    assert_text "Job offer was successfully created"
    click_on "Back"
  end

  test "should update Job offer" do
    visit job_offer_url(@job_offer)
    click_on "Edit this job offer", match: :first

    fill_in "Company", with: @job_offer.company_id
    fill_in "Hunter", with: @job_offer.hunter_id
    fill_in "Job post", with: @job_offer.job_post_id
    fill_in "Message", with: @job_offer.message
    fill_in "Offer date", with: @job_offer.offer_date
    fill_in "Salary", with: @job_offer.salary
    fill_in "Start date", with: @job_offer.start_date
    fill_in "Status", with: @job_offer.status
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
