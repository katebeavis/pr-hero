require 'rails_helper'
require 'compute_comment_stats'
require 'octokit_api'

RSpec.describe 'ComputeCommentStats' do
  let(:octokit) { OctokitApi.new }
  let(:compute_comment) { ComputeCommentStats.new(octokit.comments, octokit.issue_comments) }

  before do
    VCR.insert_cassette('issues_and_comments_on_pull_requests')
  end
  after do
    VCR.eject_cassette
  end

  describe '#merged_comments' do
    it 'returns an array' do
      expect(compute_comment.merged_comments.count).to eq(631)
    end
  end

  describe '#get_comment_authors' do
    it 'returns an array' do
      expect(compute_comment.get_commenter_user_names).to be_a(Array)
    end
  end

  describe '#get_commenter_user_names' do
    it 'returns an array' do
      expect(compute_comment.get_commenter_user_names).to be_a(Array)
    end

    it 'returns all the users who have commented on pr\'s' do
      expect(compute_comment.get_commenter_user_names.count).to eq(11)
    end

    it 'returns the names of the users who have commented on pr\'s' do
      expect(compute_comment.get_commenter_user_names).to eq(["gbkr", "marmarlade", "mottalrd", "Tomastomaslol", "orrinward", "TomGroombridge", "katebeavis", "uxdesigntom", "lukesmith", "saracen", "zopadev"])
    end
  end

  describe '#get_commenter_user_names' do
    it 'returns an array' do
      users = compute_comment.get_commenter_user_names
      expect(compute_comment.get_comments_by_user(users)).to be_a(Array)
    end
  end

  describe '#remove_duplicate_pull_requests' do
    it 'returns an array' do
      expect(compute_comment.remove_duplicate_pull_requests).to be_a(Array)
    end
  end
end
