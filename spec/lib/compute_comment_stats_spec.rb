require 'rails_helper'
require 'compute_comment_stats'
require 'octokit_api'

RSpec.describe 'ComputeCommentStats' do
  let(:octokit) { OctokitApi.new }
  let(:compute_comment) { ComputeCommentStats.new(octokit.merged_comments,) }
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

    it 'returns a nested array of comments for each user' do
      expect(compute_comment.get_comments_by_user(users).count).to eq(11)
    end

    it 'returns the correct amount of comments for each user' do
      expect(compute_comment.get_comments_by_user(users)[0].count).to eq(95)
    end
  end

  describe '#number_of_prs_contributed_to' do
    context 'all time' do
      let(:time_period) { '2016-09-21T23:45:02Z' }

      it 'returns a nested array of users and number of pr\'s contributed to' do
        expect(compute_comment.number_of_prs_contributed_to(time_period)).to eq([["gbkr", 29], ["mottalrd", 47], ["katebeavis", 37], ["TomGroombridge", 21]])
      end
    end

    context 'last 7 days' do
      let(:time_period) { '2016-10-21 12:55:26 +0100' }

      it 'returns a nested array of users and number of pr\'s contributed to' do
        expect(compute_comment.number_of_prs_contributed_to(time_period)).to eq([["gbkr", 5], ["mottalrd", 15], ["katebeavis", 8], ["TomGroombridge", 8]])
      end
    end
  end

  describe '#prepare_url_string' do
   let(:pr) { [{:html_url=>"https://github.com/zopaUK/Helium/pull/11#discussion_r81115470"}] }
    
    it 'removes everything after the pull request number' do
      expect(compute_comment.prepare_url_string(pr)).to eq(["https://github.com/zopaUK/Helium/pull/11"])
    end
  end

  describe '#number_of_duplicate_urls' do
    let(:urls) { ["https://github.com/zopaUK/Helium/pull/75", "https://github.com/zopaUK/Helium/pull/71",
    "https://github.com/zopaUK/Helium/pull/8","https://github.com/zopaUK/Helium/pull/71",
    "https://github.com/zopaUK/Helium/pull/75"] }
    
    it 'returns the number of duplicate urls' do
      expect(compute_comment.number_of_duplicate_urls(urls)).to eq(2)
    end
  end

  describe '#randomise_names' do
    let(:user_array) { [["gbkr", 29], ["mottalrd", 47], ["katebeavis", 37], ["TomGroombridge", 21]] }
    
    it 'replaces user names with a letter' do
      expect(compute_comment.randomise_names(user_array)).to eq([["A", 29], ["B", 47], ["C", 37], ["D", 21]])
    end
  end

  describe '#avg' do
    context 'all time' do
      let(:time_period) { '2016-09-21T23:45:02Z' }

      it 'returns the average amount of pull requests contributed to' do
        expect(compute_comment.avg(time_period)).to eq(33)
      end
    end

    context 'last 7 days' do
      let(:time_period) { '2016-10-21 12:55:26 +0100' }

      it 'returns the average amount of pull requests contributed to' do
        expect(compute_comment.avg(time_period)).to eq(9)
      end
    end
  end

  describe '#below_avg' do
    context 'all time' do
      let(:time_period) { '2016-09-21T23:45:02Z' }

      it 'returns half the average figure' do
        expect(compute_comment.below_avg(time_period)).to eq(16)
      end
    end

    context 'last 7 days' do
      let(:time_period) { '2016-10-21 12:55:26 +0100' }

      it 'returns half the average figure' do
        expect(compute_comment.below_avg(time_period)).to eq(4)
      end
    end
  end

  describe '#above_avg' do
    context 'all time' do
      let(:time_period) { '2016-09-21T23:45:02Z' }

      it 'returns double the average figure' do
        expect(compute_comment.above_avg(time_period)).to eq(66)
      end
    end

    context 'last 7 days' do
      let(:time_period) { '2016-10-21 12:55:26 +0100' }

      it 'returns double the average figure' do
        expect(compute_comment.above_avg(time_period)).to eq(18)
      end
    end
  end

  describe '#below_average_team_members' do
    let(:time_period) { '2016-10-21 12:55:26 +0100' }
    
    context 'in the past 7 days' do
      it 'returns a the number of team members who have performed below average' do
        expect(compute_comment.below_average_team_members(time_period)).to eq(0)
      end
    end
  end

  describe '#above_average_team_members' do
    let(:time_period) { '2016-10-21 12:55:26 +0100' }
    
    context 'in the past 7 days' do
      it 'returns a the number of team members who have performed below average' do
        expect(compute_comment.above_average_team_members(time_period)).to eq(0)
      end
    end
  end

  describe '#comments_made_by_user' do
    let(:time_period) { '2016-10-21 12:55:26 +0100' }

    it 'returns an array of users and the number of comments created in the past week' do
      expect(compute_comment.comments_made_by_user(time_period)).to eq([["gbkr", 8], ["mottalrd", 91], ["katebeavis", 28], ["TomGroombridge", 17]])
    end

    it 'returns the correct number of comments created in the past week by a user' do
      expect(compute_comment.comments_made_by_user(time_period)[0][1]).to eq(8)
    end
  end
end
