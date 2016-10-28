require 'rails_helper'
require 'compute_comment_stats'
require 'octokit_api'

RSpec.describe 'ComputeCommentStats' do
  let(:octokit) { OctokitApi.new }
  let(:compute_comment) { ComputeCommentStats.new(octokit.pull_requests) }

  before do
    VCR.insert_cassette('closed_pull_requests')
  end
  after do
    VCR.eject_cassette
  end

  describe '#get_comments_urls' do
    it 'returns an array' do
      expect(compute_comment.get_comments_urls).to be_a(Array)
    end

    it 'contains urls for all pull requests' do
      expect(compute_comment.get_comments_urls.count).to eq(57)
    end

    it 'contains the comments urls' do
      expect(compute_comment.get_comments_urls.first).to eq("https://api.github.com/repos/zopaUK/Helium/issues/59/comments")
    end
  end
end
