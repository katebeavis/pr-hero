require 'rails_helper'

RSpec.describe PullRequestsController, type: :controller do

  describe '#index' do
    render_views

    before do
      VCR.insert_cassette('closed_pull_requests')
    end
    after do
      VCR.eject_cassette
    end

    xit 'display\'s the page\'s title' do
      get :index

      expect(response.body).to have_text('PR Hero')
    end
  
  end

  describe 'high chart' do
    render_views

    it 'displays the basic line chart' do
      get :index

      expect(response.body).to have_css('div#pr')
    end
  end

end
