require "test_helper"

class JobPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_post = job_posts(:one)
    @hunter = hunters(:one)
    sign_in_as(@hunter.email_address, "password")
  end

  test "should get new" do
    get new_job_post_url
    assert_response :success
  end

  test "should create job_post" do
    assert_difference("JobPost.count") do
      post job_posts_url, params: { job_post: { apply_from_anywhere: @job_post.apply_from_anywhere, closing_date: @job_post.closing_date, company_id: @job_post.company_id, description: @job_post.description, employment_type: @job_post.employment_type, english_level: @job_post.english_level, experience: @job_post.experience, japanese_level: @job_post.japanese_level, location: @job_post.location, posted_at: @job_post.posted_at, relocation: @job_post.relocation, remote: @job_post.remote, role_id: @job_post.role_id, salary: @job_post.salary, skills_required: @job_post.skills_required, title: @job_post.title } }
    end

    assert_redirected_to job_post_url(JobPost.last)
  end

  test "should show job_post" do
    get job_post_url(@job_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_post_url(@job_post)
    assert_response :success
  end

  test "should update job_post" do
    patch job_post_url(@job_post), params: { job_post: { apply_from_anywhere: @job_post.apply_from_anywhere, closing_date: @job_post.closing_date, company_id: @job_post.company_id, description: @job_post.description, employment_type: @job_post.employment_type, english_level: @job_post.english_level, experience: @job_post.experience, japanese_level: @job_post.japanese_level, location: @job_post.location, posted_at: @job_post.posted_at, relocation: @job_post.relocation, remote: @job_post.remote, role_id: @job_post.role_id, salary: @job_post.salary, skills_required: @job_post.skills_required, title: @job_post.title } }
    assert_redirected_to job_post_url(@job_post)
  end

  test "should destroy job_post" do
    assert_no_difference("JobPost.count") do
      delete job_post_url(@job_post)
    end

    @job_post.reload
    assert @job_post.deleted
    assert_redirected_to root_url
  end
end
