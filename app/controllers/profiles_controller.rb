class ProfilesController < ApplicationController
  skip_before_action :profile_control, only: [:new, :create]

  def index
    @reserved = Array.new
    @requested_profiles = Array.new
    current_user.profile.requests.each do |req|
      @requested_profiles << req.invitee
      @reserved << req.invitee
    end

    @invited_profiles = Array.new

    current_user.profile.invites.each do |inv|
      @invited_profiles << inv.inviter
      @reserved << inv.inviter
    end

    @reserved << current_user.profile

    current_user.profile.friends.each do |fr|
      if @reserved.exclude?(fr)
        @reserved << fr
      end
    end

    @profiles = Profile.all
  end

  def new
    if current_user.profile.nil?
      @profile = Profile.new
    else
      flash[:notice] = 'you already have a profile'
      redirect_to current_user.profile
    end
  end

  def create
    @profile = Profile.new(profile_params)
    current_user.profile = @profile

    if @profile.save
      ProfileMailer.with(profile: @profile).welcome_email.deliver_later
      redirect_to @profile
    else
      render :new
    end
  end

  def show
    @profile = Profile.find(params[:id])
    @requestable = false
    @existing = FriendshipRequest.where("invitee_id = ? AND inviter_id = ?", current_user.profile.id, @profile.id)
    @existing2 = FriendshipRequest.where("inviter_id = ? AND invitee_id = ?", @current_user.profile.id, @profile.id)

    if current_user.profile.friends.exclude?(@profile) && (@existing.empty? && @existing2.empty?)
      @requestable = true
    end
  end

  def edit
    if current_user.profile.id == params[:id].to_i
      @profile = Profile.find(params[:id])
    else
      flash[:alert] = 'You can only edit your own profile'
      redirect_to current_user.profile
    end
  end

  def update
    @profile = Profile.find(params[:id])
    if current_user.profile.id == params[:id].to_i
      if @profile.update(profile_params)
        redirect_to @profile
      else
        flash.now[:notice] = 'Something went wrong'
        render :edit
      end
    else
      flash[:notice] = 'Something went wrong'
      redirect_to current_user.profile
    end
  end

  def friends
    @friends = Profile.find(params[:id]).friends
  end

  def liked_posts
    @profile = Profile.find(params[:id])
    @likes = @profile.likes
  end

  private

  def profile_params
    params.require(:profile).permit(:username, :age)
  end
end
