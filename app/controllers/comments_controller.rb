class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show]
  # GET /comments
  # GET /comments.json
  def index
     @post=Post.find(params[:post_id])
     @comments = Comment.where(post_id: params[:post_id])
     @comment = Comment.new
     @comment.user=current_user
     @comment.post=@post
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    
  end

 
  # GET /comments/new
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    @comment.user=current_user
    @comment.post=@post
  end

  # GET /comments/1/edit
  def edit
    
    @post=Post.find(params[:post_id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_post_comments_path(params[:user_id], params[:post_id]), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to user_post_comments_path(params[:user_id],params[:post_id] ), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|          
      format.html { redirect_to user_post_comments_path(@comment.post.user.id, @comment.post.id), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :content)
    end
end
