class ProfileMailer < ApplicationMailer
  default from: 'notifications@haha.com'

  def welcome_email
    @profile = params[:profile]
    mail(to: @profile.user.email, subject: 'You created a profile')
  end
end
