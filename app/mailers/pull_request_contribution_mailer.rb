require 'octokit_api'
require 'compute_comment_stats' 

class PullRequestContributionMailer < ApplicationMailer
  default from: "katebeavis84@gmail.com"

  def pull_request_contribution_email
    client = OctokitApi.new
    @merged_comments = client.merged_comments
    mail(to: "katebeavis84@gmail.com", subject: "Pull request contributions per team member")
    Rails.logger.info("Pull request contributions per team member email sent at #{Time.now}")
  end
end
