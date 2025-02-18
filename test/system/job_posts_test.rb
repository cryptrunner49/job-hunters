require "application_system_test_case"

class JobPostsTest < ApplicationSystemTestCase
  setup do
    @job_post = job_posts(:one)
  end

  test "visiting the index" do
    visit job_posts_url
    assert_selector "h1", text: "Job offers"
  end

  test "should create job offer" do
    visit job_posts_url
    click_on "New job offer"

    check "Apply from anywhere" if @job_post.apply_from_anywhere
    fill_in "Closing date", with: @job_post.closing_date
    fill_in "Company", with: @job_post.company_id
    fill_in "Description", with: @job_post.description
    fill_in "Employment type", with: @job_post.employment_type
    fill_in "English level", with: @job_post.english_level
    fill_in "Experience", with: @job_post.experience
    fill_in "Japanese level", with: @job_post.japanese_level
    fill_in "Location", with: @job_post.location
    fill_in "Posted at", with: @job_post.posted_at
    check "Relocation" if @job_post.relocation
    fill_in "Remote", with: @job_post.remote
    fill_in "Role", with: @job_post.role_id
    fill_in "Salary", with: @job_post.salary
    fill_in "Skills required", with: @job_post.skills_required
    fill_in "Title", with: @job_post.title
    click_on "Create Job offer"

    assert_text "Job offer was successfully created"
    click_on "Back"
  end

  test "should update Job offer" do
    visit job_post_url(@job_post)
    click_on "Edit this job offer", match: :first

    check "Apply from anywhere" if @job_post.apply_from_anywhere
    fill_in "Closing date", with: @job_post.closing_date.to_s
    fill_in "Company", with: @job_post.company_id
    fill_in "Description", with: @job_post.description
    fill_in "Employment type", with: @job_post.employment_type
    fill_in "English level", with: @job_post.english_level
    fill_in "Experience", with: @job_post.experience
    fill_in "Japanese level", with: @job_post.japanese_level
    fill_in "Location", with: @job_post.location
    fill_in "Posted at", with: @job_post.posted_at.to_s
    check "Relocation" if @job_post.relocation
    fill_in "Remote", with: @job_post.remote
    fill_in "Role", with: @job_post.role_id
    fill_in "Salary", with: @job_post.salary
    fill_in "Skills required", with: @job_post.skills_required
    fill_in "Title", with: @job_post.title
    click_on "Update Job offer"

    assert_text "Job offer was successfully updated"
    click_on "Back"
  end

  test "should destroy Job offer" do
    visit job_post_url(@job_post)
    click_on "Destroy this job offer", match: :first

    assert_text "Job offer was successfully destroyed"
  end
end
