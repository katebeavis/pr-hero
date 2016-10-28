class CommentsController < ApplicationController
  def index
    client = OctokitApi.new
    pull_requests = client.pull_requests
    @comment_stats = ComputeCommentStats.new(pull_requests)
  end
end
