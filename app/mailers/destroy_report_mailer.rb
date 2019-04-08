class DestroyReportMailer < ApplicationMailer
  default from: 'from@example.com'

  def destroy_report(title, email)
    @title = title
    @email = email
    mail to: @email, subject: "アジェンダ #{@title} が削除されました"
  end
end
