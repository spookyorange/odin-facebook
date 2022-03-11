class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
  end

  def create
    @user = current_user
    @profile = Profile.new(profile_creation_params)

    if @profile.save
      @user.profile = @profile
      redirect_to 'root'
    else
      render :new
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def edit
    if current_user.profile.id == params[id]
      @profile = Profile.find(params[:id])
    else
      flash[:alert] = 'You can only edit your own profile'
      redirect_to current_user.profile
    end
  end

  def update
    @profile = Profile.find[params[:id]]
    if current_user.profile.id == params[:id]
      @profile.update(profile_creation_params)
    else
      flash[:notice] = 'Something went wrong'
      redirect_to current_user.profile
    end
  end

  private

  def profile_creation_params
    params.require(:profile).permit(:username, :age)
  end
end
