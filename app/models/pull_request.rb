class PullRequest
  def initialize
    client = OctokitApi.new
    @pull_requests = client.pull_requests
  end
end
