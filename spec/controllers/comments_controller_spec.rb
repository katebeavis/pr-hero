require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe '#index' do
    render_views
    
    it 'display\'s the page\'s title' do
      get :index

      expect(response.body).to have_text('PR Hero - Comments')
    end
  end
end
