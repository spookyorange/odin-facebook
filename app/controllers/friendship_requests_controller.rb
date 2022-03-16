class FriendshipRequestsController < ApplicationController
  def index
    @requests = current_user.profile.requests
    @invites = current_user.profile.invites
  end

  def create
    @freq = FriendshipRequest.new(friend_param)
    @freq[:inviter_id] = current_user.profile.id
    @excluded = []
    @excluded << current_user.profile.friends
    @excluded << current_user.profile
    @existing = FriendshipRequest.where("invitee_id = ? AND inviter_id = ?", @freq[:invitee_id], @freq[:inviter_id])
    @existing2 = FriendshipRequest.where("inviter_id = ? AND invitee_id = ?", @freq[:invitee_id], @freq[:inviter_id])

    if @existing.empty? && @existing2.empty? && @excluded.exclude?(@freq.invitee) && @freq.save
      flash[:notice] = 'friendship request sent successfully'
      redirect_to profiles_path
    else
      flash.now[:notice] = 'something went wrong'
      redirect_to profiles_path
    end
  end

  def destroy
    @freq = FriendshipRequest.find(params[:id])
    @acceptance = params[:friendship_request][:accept].to_i
    if @acceptance == 1 && current_user.profile == @freq.invitee
      flash[:notice] = 'accepted friend request'
      @freq.inviter.friends << @freq.invitee
      @freq.invitee.friends << @freq.inviter
      @freq.destroy
      redirect_to friendship_requests_path
    elsif @acceptance == 0 && current_user.profile == @freq.invitee
      flash[:notice] = 'refused friend request'
      @freq.destroy
      redirect_to profiles_path
    elsif @acceptance == 0 && current_user.profile == @freq.inviter
      flash[:notice] = 'cancelled friend request'
      @freq.destroy
      redirect_to friendship_requests_path
    else
      flash[:notice] = 'something went wrong'
      redirect_to friendship_requests_path
    end
  end

  private

  def friend_param
    params.require(:friendship_request).permit(:invitee_id)
  end

end
