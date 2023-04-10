# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
set :job_template, "cd $(pwd) && :job"

every 2.minute do
  rake "myrailsapp:monthly_report"
end

every 2.minute do
  rake "Cron:send_cron_mail"
end

# Learn more: http://github.com/javan/whenever
