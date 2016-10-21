require 'rails_helper'
require 'octokit_api'

describe 'octokit api' do
  let(:octokit) { OctokitApi.new }

  it 'is an instance of OctokitApi' do
    expect(octokit).to be_a(OctokitApi)
  end

  it 'returns the authenticated user' do
    expect(octokit.user.name).to eq("Kate Beavis")
  end

  describe '#user' do
    it 'returns the authenticated user' do
      VCR.use_cassette('auth_user_information') do
        response = octokit
        expect(response.user.name).to eq("Kate Beavis")
      end
    end
  end

  describe '#pull_requests' do
    before do
      VCR.insert_cassette('closed_pull_requests')
    end
    after do
      VCR.eject_cassette
    end

    it 'returns an array object' do
      expect(octokit.pull_requests).to be_a(Array)
    end

    it 'returns the amount of closed pull requests' do
      expect(octokit.pull_requests.count).to eq(57)
    end
  end

  describe '#lead_time' do
    before do
      VCR.insert_cassette('open_pull_requests')
    end
    after do
      VCR.eject_cassette
    end

    xit 'returns the lead time for a pull request' do
      Timecop.freeze('2016-10-20 17:46:04 +0100')
      expect(octokit.lead_time.last).to eq(3.41)
      Timecop.return
    end
  end
end
