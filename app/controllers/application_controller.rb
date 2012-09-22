class ApplicationController < ActionController::Base
  protect_from_forgery  
  before_filter :require_login

private  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
 
  def require_login
    redirect_to(new_session_path) unless !current_user.nil?
  end
  
  def correct_user
    @user ||= User.find(params[:id])
    redirect_to(root_path) unless  @user == current_user
  end
end
