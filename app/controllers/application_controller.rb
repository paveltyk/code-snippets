class ApplicationController < ActionController::Base
  layout 'frontend'
  helper :all
  protect_from_forgery

  filter_parameter_logging :password
  helper_method :current_user

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      flash[:notice] = "You must be logged in to access this page"
      redirect_to root_path
      return false
    end
  end
  
end
