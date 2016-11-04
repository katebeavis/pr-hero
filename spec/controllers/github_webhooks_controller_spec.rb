require 'rails_helper'

RSpec.describe GithubWebhooksController, type: :controller do

  describe '#payload' do
    render_views

    let(:params) do
      # "github_webhook"=>{
      #   "ref"=>"refs/heads/another-branch",
      #   "before"=>"d13f2819f74513b7b40e2654ec49c9875046f154",
      #   "after"=>"ac65c89425890588f7fbe5f463b683e9ce9a5fbc",
      #   "created"=>false,
      #   "deleted"=>false,
      #   "forced"=>false,
      #   "base_ref"=>nil,
      #   "compare"=>"https://github.com/katebeavis/pr-hero/compare/d13f2819f745...ac65c8942589",
      #   "commits"=>[{
      #     "id"=>"ac65c89425890588f7fbe5f463b683e9ce9a5fbc",
      #     "tree_id"=>"e701d2cc557ed9dd56bfe71456254967a45c9127",
      #     "distinct"=>true,
      #     "message"=>"added event",
      #     "timestamp"=>"2016-11-03T17:51:16Z",
      #     "url"=>"https://github.com/katebeavis/pr-hero/commit/ac65c89425890588f7fbe5f463b683e9ce9a5fbc",
      #     "author"=>{
      #       "name"=>"katebeavis",
      #       "email"=>"katebeavis84@gmail.com",
      #       "username"=>"katebeavis"
      #     },
      #     "committer"=>{
      #       "name"=>"katebeavis",
      #       "email"=>"katebeavis84@gmail.com",
      #       "username"=>"katebeavis"
      #     },
      #     "added"=>[],
      #     "removed"=>[],
      #     "modified"=>["app/controllers/github_webhooks_controller.rb"]
      #   }]
      # }
    end

    it 'has params' do
      post :payload, params: params

      expect(response.body).to eq(params)
    end
  end

end
