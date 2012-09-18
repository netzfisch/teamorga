class ApplicationController < ActionController::Base
  protect_from_forgery  
  before_filter :require_login #, :only => [:show, :edit, :update] #:except => [:index]

  private
  
  def require_login
    redirect_to(new_session_path) unless !current_user.nil?
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
