require 'hipchat_api'
require 'octokit_api'
require 'compute_comment_stats'
require 'recommended_reviewer'

class GithubWebhooksController < ApplicationController

  def payload
    @client = HipchatApi.new
    octokit = OctokitApi.new
    merged_comments = octokit.merged_comments
    comment_stats = ComputeCommentStats.new(merged_comments)
    @recommended_reviewer = RecommendedReviewer.new(comment_stats)
    convert_payload
  end

  def show
  end

  def convert_payload
    @event = params[:github_webhook]
    state = @event[:action]
    options = { user: @event[:pull_request][:user][:login],
                link: @event[:pull_request][:html_url],
                user: @event[:pull_request][:user][:login],
                username: @recommended_reviewer.hipchat_username,
                merged_at: @event.dig(:pull_request, :merged_at),
                merged_by: @event.dig(:pull_request, :merged_by, :login),
                title: @event[:pull_request][:title]
              }
    @client.determine_hipchat_message(state, options)
  end

end
