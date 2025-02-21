class HomeController < ApplicationController
  allow_unauthenticated_access only: [ :index ]

  def index
    @job_posts = JobPost.all
    if authenticated?
      @job_applications = JobApplication.where(hunter_id: current_hunter.id)
    else
      @job_applications = []
    end
  end
end
