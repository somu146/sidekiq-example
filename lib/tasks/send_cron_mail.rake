namespace :Cron do
  desc "Run Send Cron Tab Mail"
  task send_cron_mail: :environment do
  	UserMailer.send_cron_mail.deliver_now
    puts "Send Cron Mail at #{Time.now}"
  end
end