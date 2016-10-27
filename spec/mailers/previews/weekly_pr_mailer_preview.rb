# Preview all emails at http://localhost:3000/rails/mailers/weekly_pr_mailer
class WeeklyPrMailerPreview < ActionMailer::Preview
  def weekly_pr_update_email_preview
    WeeklyPrMailer.weekly_pr_update_email
  end
end
