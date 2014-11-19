class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
    #@user = User.find(params[:id])
  end

  helper_method :current_user

  def user(user_id)
    @user ||= User.find(user_id) if user_id
  end

  def banner_show
    views_count % 10 == 0
  end

  helper_method :banner_show


  def current_user?(user)
  	user == current_user
  end

  helper_method :current_user?

  private

  def views_count 
    if cookies[:views].present?
      cookies[:views] = cookies[:views].to_i + 1;
    else
      cookies[:views] = 1;
    end
  end

end
