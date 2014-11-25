class SessionsController < ApplicationController
  def login
  end

  def create
  	@user = User.find_by_email(params[:email])
  	if @user && @user.authenticate(params[:password])
  		session[:user_id] = @user.id
      flash[:notice] = "You are logged in as #{@user.name}"
  		redirect_to root_path
  	else
      flash[:notice] = "Invalid email or password"
  		redirect_to :back
  	end
  end

  def logout
    cookies[:cookie_view] = nil
  	reset_session    #sesion[:user_id] = nil
  	redirect_to root_path
  end
end
