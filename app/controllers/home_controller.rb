class HomeController < ApplicationController
  allow_unauthenticated_access only: [ :index ]

  def index
    @job_posts = JobPost.where(deleted: false)
    @job_applications = []
    @interviews = []
    @job_offers = []

    if authenticated?
      @job_applications = JobApplication.where(hunter_id: current_hunter.id, deleted: false)
      @job_applications.each do |job_application|
        @interviews[job_application.id] = Interview.where(job_application_id: job_application.id, deleted: false)
        @job_offers[job_application.id] = JobOffer.where(job_application_id: job_application.id, deleted: false)
      end

    end
  end
end
