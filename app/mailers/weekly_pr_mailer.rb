require 'octokit_api'
require 'compute_pr_stats' 

class WeeklyPrMailer < ApplicationMailer
  default from: "katebeavis84@gmail.com"

  LAST_WEEK = -2
  TWO_WEEKS_AGO = -3

  def weekly_pr_update_email
    client = OctokitApi.new
    @pull_requests = client.pull_requests
    @pr_stats = ComputePRStats.new(@pull_requests)
    @last_week_stats = last_week(LAST_WEEK)
    @two_weeks_ago_stats = two_weeks_ago(TWO_WEEKS_AGO)
    @message = message_determiner
    mail(to: "katebeavis84@gmail.com", subject: "Weekly PR Update")
    Rails.logger.info("Weekly PR Update email sent at #{Time.now}")
  end

  def message_determiner
    if @last_week_stats[:avg] > @two_weeks_ago_stats[:avg]
      @message = "You did worse than the previous week"
    elsif @last_week_stats[:avg] < @two_weeks_ago_stats[:avg]
      @message = "You did better than the previous week"
    else
      @message = "You did the same as the previous week"
    end
  end

  def last_week(i)
    last_week = { avg: @pr_stats.avg[i],
                  max: @pr_stats.max[i],
                  min: @pr_stats.min[i]
                }
  end

  def two_weeks_ago(i)
    two_weeks_ago = { avg: @pr_stats.avg[i],
                      max: @pr_stats.max[i],
                      min: @pr_stats.min[i]
                    }
  end
end
