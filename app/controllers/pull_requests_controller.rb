require 'octokit_api'

class PullRequestsController < ApplicationController

  def show
    @client = OctokitApi.new
  end
end
