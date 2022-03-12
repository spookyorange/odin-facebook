class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.profile = current_user.profile
    @comment.username = @comment.profile.username
    @comment.save
    redirect_to @post
  end

  def update
    @comment = Comment.find(params[:id])
    @post = @comment.post

    if @comment.profile != current_user.profile
      flash[:alert] = 'you can not edit a comment that is not yours'
      redirect_to @post
    else
      if @comment.update(comment_params)
        flash[:notice] = 'comment edited successfully'
        redirect_to @post
      else
        flash[:notice] = 'something went wrong'
        redirect_to @post
      end
    end

  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post

    if @comment.profile != current_user.profile
      flash[:alert] = 'you can not delete a comment that is not yours'
      redirect_to @post
    else
      @comment.destroy
      redirect_to @post
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
