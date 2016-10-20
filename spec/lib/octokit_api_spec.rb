require 'rails_helper'
require 'octokit_api'

describe 'octokit api' do
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
end
