require 'rails_helper'
require 'compute_pr_stats'
require 'octokit_api'

describe 'compute pr stats' do
  let(:octokit) { OctokitApi.new }
  let(:compute) { ComputePRStats.new(octokit.pull_requests) }

  describe '#closed_at' do
    before do
      VCR.insert_cassette('closed_pull_requests')
    end
    after do
      VCR.eject_cassette
    end

    it 'returns closed at dates for PR\'s' do
      expect(compute.max(compute.data[:week1])).to eq('2016/10/21')
    end
  end
end
