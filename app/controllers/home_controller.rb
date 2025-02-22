class HomeController < ApplicationController
  allow_unauthenticated_access only: [ :index ]

  def index
    @job_posts = JobPost.where(deleted: false)
    if authenticated?
      @job_applications = JobApplication.where(hunter_id: current_hunter.id, deleted: false)
    else
      @job_applications = []
    end
  end
end
