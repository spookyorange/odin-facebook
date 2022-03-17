class ProfileMailer < ApplicationMailer
  default from: 'orange@frozen-crag-90292.herokuapp.com'

  def welcome_email
    @profile = params[:profile]
    mail(to: @profile.user.email, subject: 'You created a profile')
  end
end
