require 'octokit_api'

class PullRequestsController < ApplicationController

  def index
    client = OctokitApi.new
    @pull_requests = client.pull_requests
  end

  def lead_time
    @pull_requests.map do |p|
      t1 = p.created_at
      t2 = Time.now
      elapsed = (t2 - t1)/(60 * 60 * 24)
      elapsed.round(2)
    end
  end

end
