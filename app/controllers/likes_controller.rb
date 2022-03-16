class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    @profile = current_user.profile
    if @profile.liked_posts.exclude?(Post.find(@like.liked_post_id))
      @like.profile_like = @profile
      if @like.save
        flash[:notice] = 'you have successfully liked that post'
        redirect_to posts_path
      else
        flash[:notice] = 'something went horribly wrong'
        redirect_to posts_path
      end
    else
      flash[:notice] = 'you already have liked this post'
      redirect_to posts_path
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    flash[:notice] = 'you no longer like this post'
    redirect_to posts_path
  end

  private

  def like_params
    params.require(:like).permit(:liked_post_id)
  end
end
