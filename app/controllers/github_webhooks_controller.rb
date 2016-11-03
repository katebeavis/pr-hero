class GithubWebhooksController < ApplicationController

  def index
    @client = HipchatApi.new
  end

  def payload
    binding.pry
    @event = params
  end

  def show
    @event = params
    binding.pry
  end
end
