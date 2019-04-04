class ChangeOwnerMailer < ApplicationMailer
  default from: 'from@example.com'

  def change_owner_mail(email)
    @email = email
    @password = "password"
    mail to: @email, subject: 'オーナーが委託されました'
  end
end
