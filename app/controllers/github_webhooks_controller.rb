class GithubWebhooksController < ApplicationController
  def index
    @event = params
  end
end
