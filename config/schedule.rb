set :environment, "development"

every 5.minutes do
  runner "WeeklyPrMailer.weekly_pr_update_email"
end
