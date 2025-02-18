require "test_helper"

class JobOffersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_offer = job_offers(:one)
    @hunter = hunters(:one)
    sign_in_as(@hunter, "password")
  end

  test "should get index" do
    get job_offers_url
    assert_response :success
  end

  test "should get new" do
    get new_job_offer_url
    assert_response :success
  end

  test "should create job_offer" do
    assert_difference("JobOffer.count") do
      post job_offers_url, params: { job_offer: { company_id: @job_offer.company_id, hunter_id: @job_offer.hunter_id, job_post_id: @job_offer.job_post_id, message: @job_offer.message, offer_date: @job_offer.offer_date, salary: @job_offer.salary, start_date: @job_offer.start_date, status: @job_offer.status } }
    end

    assert_redirected_to job_offer_url(JobOffer.last)
  end

  test "should show job_offer" do
    get job_offer_url(@job_offer)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_offer_url(@job_offer)
    assert_response :success
  end

  test "should update job_offer" do
    patch job_offer_url(@job_offer), params: { job_offer: { company_id: @job_offer.company_id, hunter_id: @job_offer.hunter_id, job_post_id: @job_offer.job_post_id, message: @job_offer.message, offer_date: @job_offer.offer_date, salary: @job_offer.salary, start_date: @job_offer.start_date, status: @job_offer.status } }
    assert_redirected_to job_offer_url(@job_offer)
  end

  test "should destroy job_offer" do
    assert_no_difference("JobOffer.count") do
      delete job_offer_url(@job_offer)
    end

    @job_offer.reload
    assert @job_offer.deleted
    assert_redirected_to job_offers_url
  end

  private

  def sign_in_as(hunter, password)
    post session_url, params: { email_address: hunter.email_address, password: password }
  end
end
