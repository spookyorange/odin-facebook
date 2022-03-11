class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :profile_control

  def profile_control
    if user_signed_in? && current_user.profile.nil?
      redirect_to new_profile_path
    end
  end
end
