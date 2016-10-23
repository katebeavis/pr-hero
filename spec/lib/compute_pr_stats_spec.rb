require 'rails_helper'
require 'compute_pr_stats'
require 'octokit_api'

describe 'compute pr stats' do
  let(:octokit) { OctokitApi.new }
  let(:compute) { ComputePRStats.new(octokit.pull_requests) }
  let(:dummy_data) { {
        week1: {
                  '2016-10-01': 3.5,
                  '2016-10-02': 2.0,
                  '2016-10-03': 1.0,
                  '2016-10-04': 5.0,
                  '2016-10-05': 4.5
                  }
      } }

  before do
    VCR.insert_cassette('closed_pull_requests')
  end
  after do
    VCR.eject_cassette
  end

  describe '#lead_time_per_pull_request' do
    it 'returns an array' do
      expect(compute.lead_time_per_pull_request).to be_a(Array)
    end

    it 'contains a hash of the pull request closed date and lead time' do
      data = compute.lead_time_per_pull_request
      expect(data.first).to eq({:date=>"2016-10-20", :lead_time=>0.84})
    end
  end

  describe '#lead_time_per_day' do
    it 'returns a hash' do
      expect(compute.lead_time_per_day).to be_a(Hash)
    end

    it 'sums up lead time for each day' do
      hash = compute.lead_time_per_day
      expect(hash.values[0]).to eq(1.77)
    end
  end

  describe '#avg' do
    it 'returns the average pull request lead time for every week that has data' do
      expect(compute.avg).to eq([3.2, 3.0, 3.2])
    end
  end

  describe '#max' do
    it 'returns the max pull request lead time for a week' do
      expect(compute.max).to eq([5.0, 4.5, 5.0])
    end
  end

  describe '#min' do
    it 'returns the min pull request lead time for a week' do
      expect(compute.min).to eq([1.0, 1.0, 1.0])
    end
  end
end
