require 'rails_helper'
require 'octokit_api'

RSpec.describe 'OctokitApi' do
  let(:octokit) { OctokitApi.new }

  it 'is an instance of OctokitApi' do
    expect(octokit).to be_a(OctokitApi)
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

  describe '#comments' do
    # before do
    #   VCR.insert_cassette('comments_on_pull_requests')
    # end
    # after do
    #   VCR.eject_cassette
    # end

    it 'returns an array object' do
      expect(octokit.comments).to be_a(Array)
    end

    it 'returns the amount of closed pull requests' do
      expect(octokit.comments.count).to eq(489)
    end
  end
end
