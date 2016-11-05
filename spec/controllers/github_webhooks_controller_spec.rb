require 'rails_helper'
require 'hipchat_api'

RSpec.describe GithubWebhooksController, type: :controller do

  before do
    VCR.insert_cassette('github_payload')
  end
  after do
    VCR.eject_cassette
  end

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
            "login": "katebeavis"
          },
          "merged_at": nil,
        }
      }
    }
  end

  describe '#payload' do
    render_views

    it 'returns a successful response' do
      post :payload, params: params

      expect(response.status).to eq(200)
    end
  end

  describe '#convert_payload' do
    context 'opened pull requests' do
      it 'sends the required params to the hipchat api class' do
        expect_any_instance_of(HipchatApi).to receive(:determine_hipchat_message).with("opened", {:user=>"katebeavis", :link=>"https://github.com/katebeavis/pr-hero/pull/10", :username=>"@TomGroombridge", :merged_at=>"", :merged_by=>nil, :title=>"fix issue with pr state"})

        post :payload, params: params
      end
    end
  end

end
