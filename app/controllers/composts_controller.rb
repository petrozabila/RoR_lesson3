class CommentsController < ApplicationController
  #before_action :set_comment, only: [:show, :create, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /comments
  # GET /comments.json
  def index
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    @composts = @comment.composts
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @compost = Compost.new(compost_params)
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    @compost = @comment.composts.new(compost_params)
    @compost.user_id = current_user.id
    @compost.user = current_user

    @compost.save
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
    @compost.destroy
    respond_to do |format|
      format.html { redirect_to composts_url, notice: 'You have shared your opinion. Thank you!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between action
    # Never trust parameters from the scary internet, only allow the white list through.
    def compost_params
      params.require(:compost).permit(:body)
    end
end
