class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

	def index
	  @posts = Post.all.order(:updated_at).reverse
	  #@user = User.find(params[:id]) 
	  #render text: "hello"
	  #@name = params[:name]

	 
	 	#cookies[:view] = if cookies[:view].present? 
	 		#cookies[:view]to_i +1
	 

	end
	# GET /posts/1
	def show
		@post = Post.find(params[:id])
	end
	# GET /posts/new
	def new
	  @post = Post.new
	end
	# GET /posts/1/edit
	def edit
		@post = Post.find(params[:id])
      if current_user?(@post.user)
        redirect_to :back
        flash[:notice] = 'You can not edit this post'
    end

	end
	# POST /posts
	def create
		#@user = User.find(params[:id])
	  @post = Post.new(post_params)
	   if @post.save
	    redirect_to @post, notice: 'Post was successfully created.'
	   else
	    render :new
	   end
	end
	# PATCH/PUT /posts/1
	def update
	  if @post.update(post_params)
	    redirect_to @post, notice: 'Post was successfully updated.' #redirect_to post_path(@post) OR redirect_to post_path(params[:id])
	  else
	    render :edit
	  end
	end
	# DELETE /posts/1
	def destroy
	  @post.destroy
	  redirect_to posts_url, notice: 'Post was successfully destroyed.'
	end
	

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_post
	  @post = Post.find(params[:id])
	end
	# Only allow a trusted parameter "white list" through.
	def post_params
	  params.require(:post).permit(:title, :body)
	end

end
