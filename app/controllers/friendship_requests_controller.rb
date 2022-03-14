class FriendshipRequestsController < ApplicationController
  def index
    @requests = current_user.profile.requests
    @invites = current_user.profile.invites

  end

  def create
    @freq = FriendshipRequest.new(friend_param)
    @freq[:inviter_id] = current_user.profile.id

    if @freq.save
      flash[:notice] = 'friendship request sent successfully'
      render :'profiles/index'
    else
      flash.now[:notice] = 'something went wrong'
      render :'profiles/index'
    end
  end

  def destroy
    @freq = FriendshipRequest.find(params[:id])
    if params[:accept] == 1
      flash.now[:notice] = 'accepted friend request'
      @freq.inviter.friends << @freq.invitee
      @freq.invitee.friends << @freq.inviter
      @freq.destroy
      render :'friendship_requests/index'
    elsif params[:accept] == 0
      flash.now[:notice] = 'refused friend request'
      @freq.destroy
      render :'friendship_requests/index'
    else
      flash.now[:notice] = 'something went wrong'
      render :'friendship_requests/index'
    end
  end

  private

  def friend_param
    params.require(:FriendshipRequest).permit(:invitee_id)
  end

end
