class ProfileMailer < ApplicationMailer

  def welcome_email
    @profile = params[:profile]
    mail(to: @profile.user.email, subject: 'You created a profile')
  end
end
