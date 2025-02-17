class HomeController < ApplicationController
  allow_unauthenticated_access only: [ :index ]

  def index
    # Publicly accessible action
  end
end
