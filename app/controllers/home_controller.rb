class HomeController < ApplicationController
  allow_unauthenticated_access only: [ :index ]

  def index
    @job_posts = JobPost.all
    @job_applications = JobApplication.all
  end
end
