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

  describe '#avg' do
    it 'returns the average pr lead time for every week that has data' do
      expect(compute.avg).to eq([3.2, 3.0, 3.2])
    end
  end

  describe '#max' do
    it 'returns the max pr lead time for a week' do
      expect(compute.max).to eq([5.0, 4.5, 5.0])
    end
  end

  describe '#min' do
    it 'returns the min pr lead time for a week' do
      expect(compute.min).to eq([1.0, 1.0, 1.0])
    end
  end
end
