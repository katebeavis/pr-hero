require 'rails_helper'
require 'compute_comment_stats'
require 'octokit_api'

RSpec.describe 'ComputeCommentStats' do
  let(:octokit) { OctokitApi.new }
  let(:compute_comment) { ComputeCommentStats.new(octokit.comments, octokit.issue_comments) }
  let(:users) { compute_comment.comment_authors }

  before do
    VCR.insert_cassette('pull_request_comments')
  end
  after do
    VCR.eject_cassette
  end

  describe '#comment_authors' do
    it 'returns an array' do
      expect(compute_comment.comment_authors).to be_a(Array)
    end
  end

  describe '#comment_authors' do
    it 'returns an array' do
      expect(compute_comment.comment_authors).to be_a(Array)
    end

    it 'returns all the users who have commented on pr\'s' do
      expect(compute_comment.comment_authors.count).to eq(11)
    end

    it 'returns the names of the users who have commented on pr\'s' do
      expect(compute_comment.comment_authors).to eq(["gbkr", "marmarlade", "mottalrd", "katebeavis", "orrinward", "Tomastomaslol", "TomGroombridge", "uxdesigntom", "lukesmith", "saracen", "zopadev"])
    end
  end

  describe '#get_comments_by_user' do

    it 'returns an array' do
      expect(compute_comment.get_comments_by_user(users)).to be_a(Array)
    end

    it 'returns an array of comments for each user' do
      expect(compute_comment.get_comments_by_user(users).count).to eq(11)
    end

    it 'returns the correct amount of comments for each user' do
      expect(compute_comment.get_comments_by_user(users)[0].count).to eq(95)
    end
  end

  describe '#number_of_prs_contributed_to' do
    it 'returns an array of users and number of pr\'s contributed to' do
      expect(compute_comment.number_of_prs_contributed_to).to eq([["gbkr", 30], ["mottalrd", 47], ["katebeavis", 37], ["TomGroombridge", 21]])
    end
  end

  describe '#prepare_url_string' do
   let(:pr) { [{:html_url=>"https://github.com/zopaUK/Helium/pull/11#discussion_r81115470"}] }
    it 'removes everything after the pull request number' do
      expect(compute_comment.prepare_url_string(pr)).to eq(["https://github.com/zopaUK/Helium/pull/11"])
    end
  end

  describe '#find_duplicate_urls' do
    let(:urls) { ["https://github.com/zopaUK/Helium/pull/75", "https://github.com/zopaUK/Helium/pull/71",
    "https://github.com/zopaUK/Helium/pull/8","https://github.com/zopaUK/Helium/pull/71",
    "https://github.com/zopaUK/Helium/pull/75"] }
    it 'returns the number of duplicate urls' do
      expect(compute_comment.find_duplicate_urls(urls)).to eq(2)
    end
  end
end
