class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  #before_action :check_post_user, only: [:edit, :update, :destroy]
  	def upvote
	  @post = Post.find(params[:id])
	  @post.upvote_by current_user
	  redirect_to root_path

	end

	def downvote
	  @post = Post.find(params[:id])
	  @post.downvote_by current_user
	  redirect_to root_path
	end


	def index
		#@posts = Post.paginate(:page => params[:page], :per_page => 6)
    	@posts = Post.paginate(:page => params[:page], :per_page => 2)
    	@number = current_user.posts.count if current_user

    	respond_to do |format|
	      format.html
	      format.json {
	        render json: @posts.to_json(only: [:id, :body, :tags], include: {user: {only: :name}})
	      }

		@users = User.all
		
		#@comments = Comment.all
    	end
	end



		#@post = Post.find(params[:post_id])
		#@comment = @post.comments.create(params[:comment])
		#@user = User.find(params[:id])
		#@current_user.posts = Post.where(session[:user_id])
		#@user = User.find(params[:id]) 
		#render text: "hello"
		#@name = params[:name]

	 
	 	#cookies[:view] = if cookies[:view].present? 
	 		#cookies[:view]to_i +1
	 


	# GET /posts/1
	def show
		#@user = User.find(params[:id])
		#@posts = Post.where(user_id: @user.id)
		@posts = Post.all
		@comments = @post.comments
			respond_to do |format|
		      format.html
		      format.json {
		        render json: @post.to_json(except: [:updated_at, :user_id], include: {user: {only: :name}})
	          }
        end
	end
	# GET /posts/new
	
	def new
	  @post = Post.new
	end
	# GET /posts/1/edit
	def edit
		@post = Post.find(params[:id])
      unless current_user?(@post.user)
        redirect_to :back
        flash[:notice] = 'You can not edit this post'
      end
	end

	# POST /posts
	def create
	  @post = Post.new(post_params)
	  @post.user_id = current_user.id
	  @post.user = current_user
	  
		 if @post.save
		 	redirect_to @post, notice: 'Post was successfully created.'
		 else
		   render :new
		end
    end
	# PATCH/PUT /posts/1
	def update
		@post = Post.find(params[:id])
	  if @post.update(post_params)
	    redirect_to @post, notice: 'Post was successfully updated.' #redirect_to post_path(@post) OR redirect_to post_path(params[:id])
	  else
	    render :edit
	  end
	end
	# DELETE /posts/1
	def destroy
        @post = Post.find(params[:id])
      unless current_user?(@post.user)
        redirect_to :back
        flash[:notice] = 'You can not delete this post'
      else
        @post.destroy
        respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end
	

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_post
	  @post = Post.find(params[:id])
	end

	def check_post_user
	    unless current_user == @post.user
	      redirect_to root_path
	    end
    end
	
	# Only allow a trusted parameter "white list" through.
	def post_params
	  params.require(:post).permit(:title, :body, :tags)
	end

end
