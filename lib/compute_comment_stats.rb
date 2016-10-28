class ComputeCommentStats
  def initialize(pull_requests)
    @pull_requests = pull_requests
  end

  def get_comments_urls
    url = []
    @pull_requests.map { |p| url << p.comments_url }
    url
  end
end
