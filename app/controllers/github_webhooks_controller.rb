class GithubWebhooksController < ApplicationController
  def index
  end

  def show
    @event = params
  end
end
