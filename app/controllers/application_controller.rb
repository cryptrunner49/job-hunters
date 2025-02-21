class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_hunter

  def current_hunter
    @current_hunter ||= Hunter.find(session[:hunter_id]) if session[:hunter_id]
  end
end
