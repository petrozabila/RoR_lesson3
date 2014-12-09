class CommentsController < ApplicationController
  #before_action :set_comment, only: [:show, :create, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comment = Comment.find(params[:comment_id])
    @composts = @comment.composts
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new(comment_params)
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.user = current_user

    @comment.save
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
      end
  end
  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between action
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
