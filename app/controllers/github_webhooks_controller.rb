class GithubWebhooksController < ApplicationController
  def index
    @event = params
    binding.pry
  end
end
