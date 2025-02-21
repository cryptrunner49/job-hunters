class HomeController < ApplicationController
  allow_unauthenticated_access only: [ :index ]

  def index
    @job_posts = JobPost.all
    @job_applications = JobApplication.where(hunter_id: current_hunter.id)
  end
end
