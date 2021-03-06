class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login

  helper_method :current_user #, :correct_user

private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def correct_user
    @user ||= User.find(params[:id])
    redirect_to(root_path) unless current_user == @user || current_user.admin
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section!"
      redirect_to new_session_path # halts request cycle
    end
  end

  # The logged_in? method simply returns true if the user is logged
  # in and false otherwise. It does this by "booleanizing" the
  # current_user method we created previously using a double ! operator.
  # Note that this is not common in Ruby and is discouraged unless you
  # really mean to convert something into true or false.
  def logged_in?
    !!current_user
  end
end

