require 'octokit_api'
require 'compute_comment_stats' 

class PullRequestContributionMailer < ApplicationMailer
  default from: "katebeavis84@gmail.com"


  def pull_request_contribution_email
    client = OctokitApi.new
    merged_comments = client.merged_comments
    @comment_stats = ComputeCommentStats.new(merged_comments)
    @below_average_message = print_below_average_stats_message
    @above_average_message = print_above_average_stats_message
    mail(to: "katebeavis84@gmail.com", subject: "Pull request contributions per team member")
    Rails.logger.info("Pull request contributions per team member email sent at #{Time.now}")
  end

  def below_average_stats
    @comment_stats.below_average_team_members(Time.now - 1.week)
  end

  def above_average_stats
    @comment_stats.above_average_team_members(Time.now - 1.week)
  end

  def print_below_average_stats_message
    if below_average_stats >= 1
      @below_average_message = "#{below_average_stats} team member(s) have contributed below average in the past 7 days"
    else
      @below_average_message = "Nobody has performed below average this week"
    end
  end

  def print_above_average_stats_message
    if above_average_stats >= 1
      @above_average_message = "#{above_average_stats} team member(s) have contributed above average in the past 7 days"
    else
      @above_average_message = "Nobody has performed above average this week"
    end
  end
end
