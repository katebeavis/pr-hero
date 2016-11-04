require 'rails_helper'
require 'octokit_api'
require 'compute_comment_stats'
require 'recommended_reviewer'

RSpec.describe 'RecommendedReviewer' do
  let(:octokit) { OctokitApi.new }
  let(:comment_stats) { ComputeCommentStats.new(octokit.merged_comments) }
  let(:recommended_reviewer) { RecommendedReviewer.new(comment_stats) }

  before do
    VCR.insert_cassette('pull_request_and_comments')
  end
  after do
    VCR.eject_cassette
  end

  describe '#initialize' do
    it 'is an instance of RecommendedReviewer' do
      expect(recommended_reviewer).to be_a(RecommendedReviewer)
    end
  end

  describe '#get_recommended_reviewer' do
    it 'returns the name of the user that has made the fewest comments in the past week' do
      expect(recommended_reviewer.get_recommended_reviewer).to eq("katebeavis")
    end
  end

  describe '#hipchat_username' do
    it 'returns the hipchat username of the recommended reviewer' do
      expect(recommended_reviewer.hipchat_username).to eq("@KateBeavis")
    end
  end
end
