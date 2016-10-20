require 'octokit_api'

class PullRequestsController < ApplicationController

  def index
    @client = OctokitApi.new
  end

  # t1 = created_at
  # t2 = Time.now
  # elapsed = (t2-t1)/(60*60*24)
  # elapsed.round(2)
  # "#{elapsed.round(2)} days"


end
