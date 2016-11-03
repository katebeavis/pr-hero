class GithubWebhooksController < ApplicationController
  def payload
  end

  def show
    @event = params
  end
end
