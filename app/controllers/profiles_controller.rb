class ProfilesController < ApplicationController
  skip_before_action :profile_control, only: [:new, :create]

  def index
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
      redirect_to @profile
    else
      render :new
    end
  end

  def show
    @profile = Profile.find(params[:id])
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
      @profile.update(profile_params)
      redirect_to @profile
    else
      flash[:notice] = 'Something went wrong'
      redirect_to current_user.profile
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:username, :age)
  end
end
