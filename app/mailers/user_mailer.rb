class UserMailer < ApplicationMailer

  def send_cron_mail
    mail(to: "somtest396@gmail.com", subject: "Cron Job Update")
  end

end