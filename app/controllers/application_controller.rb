class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_hunter, :hunter_signed_in?

  def current_hunter
    @current_hunter ||= Hunter.find(session[:hunter_id]) if session[:hunter_id]
  end

  def hunter_signed_in?
    current_hunter.present?
  end
end
