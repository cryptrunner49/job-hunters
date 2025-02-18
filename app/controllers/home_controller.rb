class HomeController < ApplicationController
  allow_unauthenticated_access only: [ :index ]

  def index
    @job_offers = JobOffer.all
    @job_applications = JobApplication.all
  end
end
