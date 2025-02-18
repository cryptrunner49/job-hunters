require "test_helper"

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company = companies(:one)
    @hunter = hunters(:one)  # Assuming you have a hunter fixture for authentication
    sign_in_as(@hunter, "password")  # Sign in the hunter before running the tests
  end

  test "should get index" do
    get companies_url
    assert_response :success
  end

  test "should get new" do
    get new_company_url
    assert_response :success
  end

  test "should create company" do
    assert_difference("Company.count") do
      post companies_url, params: { company: { description: @company.description, github: @company.github, industry: @company.industry, job_search_website: @company.job_search_website, location: @company.location, name: @company.name, website: @company.website } }
    end

    assert_redirected_to company_url(Company.last)
  end

  test "should show company" do
    get company_url(@company)
    assert_response :success
  end

  test "should get edit" do
    get edit_company_url(@company)
    assert_response :success
  end

  test "should update company" do
    patch company_url(@company), params: { company: { description: @company.description, github: @company.github, industry: @company.industry, job_search_website: @company.job_search_website, location: @company.location, name: @company.name, website: @company.website } }
    assert_redirected_to company_url(@company)
  end

  test "should destroy company" do
    # Ensure any dependent records are handled before deleting the company
    @company.job_posts.destroy_all if @company.respond_to?(:job_posts)

    assert_difference("Company.count", -1) do
      delete company_url(@company)
    end

    assert_redirected_to companies_url
  end

  private

  def sign_in_as(hunter, password)
    post session_url, params: { email_address: hunter.email_address, password: password }
  end
end
