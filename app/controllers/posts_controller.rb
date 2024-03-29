class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
skip_before_action :authenticate_user!, only: [:show, :index, :search]
  # GET /posts
  # GET /posts.json
  def index
  @posts = Post.where(user_id: params[:user_id]).order(created_at: :desc)
  @user=User.find(params[:user_id])
  @u=@user.nickname

       end


  def search 
    @posts= Post.where("tag like ?","%#{params[:search]}%")+Post.where("title like ?","%#{params[:search]}%")

  end


  
  # GET /posts/1
  # GET /posts/1.json
  # 
  def show
   @c=Comment.where(post_id: @post.id).count
  @user=User.where(user_id: params[:user_id])
  
   end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id=current_user.id
    @picture=PictureUploader.new
    if params[:picture] != nil
     picture.store!(File.open(params[:post][:picture].path))
    end
    respond_to do |format|
      if @post.save
        format.html { redirect_to user_post_path(user_id: @post.user.id,  id: @post.id), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to user_post_path(user_id: @post.user.id,  id: @post.id), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
     @posts = Post.where(user_id: params[:user_id])
    respond_to do |format|
      format.html { redirect_to user_posts_path(@post.user.id), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :tag, :privacy, :picture)
    end
end
