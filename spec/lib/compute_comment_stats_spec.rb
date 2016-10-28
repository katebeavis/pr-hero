require 'rails_helper'
require 'compute_comment_stats'
require 'octokit_api'

RSpec.describe 'compute_comment_stats' do
  let(:octokit) { OctokitApi.new }
  let(:compute_comment) { ComputeCommentStats.new(octokit.pull_requests) }
end
