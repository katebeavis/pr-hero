require 'hipchat_api'

class GithubWebhooksController < ApplicationController

  def payload
    @client = HipchatApi.new
    @event = params[:github_webhook]
    state = @event[:action]
    user = @event[:pull_request][:user][:login]
    link = @event[:pull_request][:html_url]
    if state == 'opened' || state == 'reopened'
      @client.send_message("Notifications", "Pull request #{state} by #{user} <a href=#{link}>#{link}</a>")
      @client.send_message("Notifications", "@KateBeavis should take a look", :message_format => "text")
    end
  end

  def show
  end

end
