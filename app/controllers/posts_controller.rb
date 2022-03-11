class PostsController < ApplicationController
  def index

  end

  def show
    @post = Post.find(params[:id])
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

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
