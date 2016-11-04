require 'hipchat_api'
require 'octokit_api'
require 'compute_comment_stats'
require 'recommended_reviewer'

class GithubWebhooksController < ApplicationController

  def payload
    client = HipchatApi.new
    octokit = OctokitApi.new
    merged_comments = octokit.merged_comments
    comment_stats = ComputeCommentStats.new(merged_comments)
    @recommended_reviewer = RecommendedReviewer.new(comment_stats)
    username = @recommended_reviewer.hipchat_username
    @event = params[:github_webhook]
    state = @event[:action]
    user = @event[:pull_request][:user][:login]
    link = @event[:pull_request][:html_url]
    if state == 'opened' || state == 'reopened'
      client.send_message("Notifications", "Pull request #{state} by #{user} <a href=#{link}>#{link}</a>")
      client.send_message("Notifications", "#{username} should take a look", :message_format => "text")
    end
  end

  def show
  end

end
