require "test_helper"

class JobOffersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_offer = job_offers(:one)
    @job_application = job_applications(:one)
    @hunter = hunters(:one)
    sign_in_as(@hunter.email_address, "password")
  end

  test "should get new" do
    get new_job_application_job_offer_url(@job_application)
    assert_response :success
  end

  test "should create job_offer" do
    assert_difference("JobOffer.count") do
      post job_application_job_offers_url(@job_application), params: { job_offer: {
        job_application_id: @job_offer.job_application_id,
        message: @job_offer.message,
        offer_date: @job_offer.offer_date,
        salary: @job_offer.salary,
        start_date: @job_offer.start_date,
        status: @job_offer.status
      } }
    end

    assert_redirected_to job_application_job_offer_url(@job_application, JobOffer.last)
  end

  test "should show job_offer" do
    get job_application_job_offer_url(@job_application, @job_offer)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_application_job_offer_url(@job_application, @job_offer)
    assert_response :success
  end

  test "should update job_offer" do
    patch job_application_job_offer_url(@job_application, @job_offer), params: { job_offer: {
      job_application_id: @job_offer.job_application_id,
      message: @job_offer.message,
      offer_date: @job_offer.offer_date,
      salary: @job_offer.salary,
      start_date: @job_offer.start_date,
      status: @job_offer.status
    } }
    assert_redirected_to job_application_job_offer_url(@job_application, @job_offer)
  end

  test "should destroy job_offer" do
    assert_no_difference("JobOffer.count") do
      delete job_application_job_offer_url(@job_application, @job_offer)
    end

    @job_offer.reload
    assert @job_offer.deleted
    assert_redirected_to job_application_job_offers_url(@job_application)
  end
end
