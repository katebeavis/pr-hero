require 'rails_helper'
require 'compute_comment_stats'
require 'octokit_api'

RSpec.describe 'ComputeCommentStats' do
  let(:octokit) { OctokitApi.new }
  let(:compute_comment) { ComputeCommentStats.new(octokit.pull_requests) }
end
