class WeeklyPrMailer < ApplicationMailer
  default from: "katebeavis84@gmail.com"

  def weekly_pr_update_email
    @recipient = "katebeavis84@gmail.com"
    mail(to: @recipient, subject: "Weekly PR Update")
    Rails.logger.info("Weekly PR Update email sent at #{Time.now}")
  end
end
