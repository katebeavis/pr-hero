require 'rails_helper'

RSpec.describe PullRequestsController, type: :controller do

  describe '#show' do
    render_views

    it 'shows the page\'s title' do
      get :show

      expect(response.body).to have_text('Dinnr')
    end
  end

end
