require 'rails_helper'

RSpec.describe PullRequestsController, type: :controller do

  describe '#index' do
    render_views

    before do
      VCR.insert_cassette('pull_requests')
    end
    after do
      VCR.eject_cassette
    end

    it 'display\'s the page\'s title' do
      get :index

      expect(response.body).to have_text('PR Hero')
    end

    it 'display\'s the a list of pull requests' do
      get :index

      expect(response.body).to have_text('Updated the page sections with headers, and breakpoint font styling.')
    end
  end

end
