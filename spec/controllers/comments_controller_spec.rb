require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe '#index' do
    render_views

    it 'display\'s the page\'s title' do
      get :index

      expect(response.body).to have_text('PR Hero - Comments')
    end
  end

  describe 'high chart' do
    render_views

    it 'displays the basic bar chart' do
      get :index

      expect(response.body).to have_css('div#comment')
    end
  end
end
