class PostsController < ApplicationController
  def index
    @posts = Array.new
    Post.where(profile_id: current_user.profile.friends).or(Post.where(profile_id: current_user.profile)).order(:created_at).each do |post|
      @posts << post
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.profile = current_user.profile

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])

    if current_user.profile != @post.profile
      flash[:alert] = 'you can not edit a post that is not yours'
      redirect_to @post
    end
  end

  def update
    @post = Post.find(params[:id])

    if current_user.profile != @post.profile
      flash[:alert] = 'you can not edit a post that is not yours'
      redirect_to @post
    else
      if @post.update(post_params)
        flash[:notice] = 'post has been successfully edited'
        redirect_to @post
      else
        flash.now[:notice] = 'something went wrong, try again'
        render :new
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if current_user.profile != @post.profile
      flash[:alert] = 'you can not delete a post that is not yours'
    else
      if @post.destroy
        flash[:alert] = 'post has been successfully deleted'
        redirect_to :root
      end
    end
  end

  def liked_by
    @post = Post.find(params[:id])
    @likes = @post.likes
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
