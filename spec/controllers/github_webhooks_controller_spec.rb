require 'rails_helper'
require 'hipchat_api'

RSpec.describe GithubWebhooksController, type: :controller do
  let(:hipchat) { HipchatApi.new }

  describe '#payload' do
    render_views

    let(:params) do
      { "github_webhook": {
          "action": "opened",
          "number": 10,
          "pull_request": {
            "url": "https://api.github.com/repos/katebeavis/pr-hero/pulls/10",
            "id": 92318905,
            "html_url": "https://github.com/katebeavis/pr-hero/pull/10",
            "diff_url": "https://github.com/katebeavis/pr-hero/pull/10.diff",
            "patch_url": "https://github.com/katebeavis/pr-hero/pull/10.patch",
            "issue_url": "https://api.github.com/repos/katebeavis/pr-hero/issues/10",
            "number": 10,
            "state": "open",
            "locked": false,
            "title": "fix issue with pr state",
            "user": {
              "login": "katebeavis",
              "id": 10133018,
              "avatar_url": "https://avatars.githubusercontent.com/u/10133018?v=3",
              "gravatar_id": "",
              "url": "https://api.github.com/users/katebeavis",
              "html_url": "https://github.com/katebeavis",
              "followers_url": "https://api.github.com/users/katebeavis/followers",
              "following_url": "https://api.github.com/users/katebeavis/following{/other_user}",
              "gists_url": "https://api.github.com/users/katebeavis/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/katebeavis/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/katebeavis/subscriptions",
              "organizations_url": "https://api.github.com/users/katebeavis/orgs",
              "repos_url": "https://api.github.com/users/katebeavis/repos",
              "events_url": "https://api.github.com/users/katebeavis/events{/privacy}",
              "received_events_url": "https://api.github.com/users/katebeavis/received_events",
              "type": "User",
              "site_admin": false
            }
          }
        }
      }
    end

    it 'returns a successful response' do
      post :payload, params: params

      expect(response.status).to eq(200)
    end

    context 'open pull requests' do
      it 'sends a message' do
        expect_any_instance_of(HipchatApi).to receive(:send_message).twice

        post :payload, params: params
      end
    end

    context 'reopened pull requests' do
      before do
        params[:github_webhook][:action] = 'reopened'
      end
      
      it 'sends a message' do
        expect_any_instance_of(HipchatApi).to receive(:send_message).twice

        post :payload, params: params
      end
    end

    context 'closed pull requests' do
      before do
        params[:github_webhook][:action] = 'closed'
      end

      it 'does NOT send a message' do
        expect_any_instance_of(HipchatApi).not_to receive(:send_message)

        post :payload, params: params
      end
    end
  end

end
