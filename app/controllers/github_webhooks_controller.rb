class GithubWebhooksController < ApplicationController

  def index
    @client = HipchatApi.new
  end

  def payload
    @event = params
    self.send_message('Notifications', 'Hello World')
  end

  def show
  end

  def send_message(username, message)
    @client['3287218'].send(username, message)
  end
end
