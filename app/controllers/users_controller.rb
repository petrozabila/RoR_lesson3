class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id]) 
    @posts = @user.posts
    #@posts = current_user.posts
    #@posts = Post.where(user_id: @user.id)
    #@posts = Post.find(params[:user_id])
    #@name = params[:name]
  end

  
  def create
  	@user = User.new(params.require(:user).permit(:name, :email, :password))
  	if @user.save
      session[:user_id] = @user.id 
  	  redirect_to @user
    else
  	  redirect_to :back
    end 
  end




  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @user = User.find(params[:id])
  end


  def user_params
    params.require(:user).permit(:name, :email, :password_digest)
  end
end
