class PassengerMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def thank_you_email(user)
    @user = user
    mail(to: @user[:email], subject: 'Thanks for booking')
  end
end
