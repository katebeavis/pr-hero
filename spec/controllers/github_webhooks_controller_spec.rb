require 'rails_helper'

RSpec.describe GithubWebhooksController, type: :controller do

  describe '#payload' do
    render_views

    let(:params) do
      # { "ref"=>"refs/heads/another-branch",
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
      #       "username"=>"katebeavis"},
      #     "committer"=>{"name"=>"katebeavis",
      #       "email"=>"katebeavis84@gmail.com",
      #       "username"=>"katebeavis"},
      #     "added"=>[],
      #     "removed"=>[],
      #     "modified"=>["app/controllers/github_webhooks_controller.rb"]
      #   }],
      #   "head_commit"=>{
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
      #   },
      #   "repository"=>{
      #     "id"=>71728607,
      #     "name"=>"pr-hero",
      #     "full_name"=>"katebeavis/pr-hero",
      #     "owner"=>{
      #       "name"=>"katebeavis",
      #       "email"=>"katebeavis84@gmail.com"
      #   },
      #   "private"=>false,
      #   "html_url"=>"https://github.com/katebeavis/pr-hero",
      #   "description"=>nil,
      #   "fork"=>false,
      #   "url"=>"https://github.com/katebeavis/pr-hero",
      #   "forks_url"=>"https://api.github.com/repos/katebeavis/pr-hero/forks",
      #   "keys_url"=>"https://api.github.com/repos/katebeavis/pr-hero/keys{/key_id}",
      #   "collaborators_url"=>"https://api.github.com/repos/katebeavis/pr-hero/collaborators{/collaborator}",
      #   "teams_url"=>"https://api.github.com/repos/katebeavis/pr-hero/teams",
      #   "hooks_url"=>"https://api.github.com/repos/katebeavis/pr-hero/hooks",
      #   "issue_events_url"=>"https://api.github.com/repos/katebeavis/pr-hero/issues/events{/number}",
      #   "events_url"=>"https://api.github.com/repos/katebeavis/pr-hero/events",
      #   "assignees_url"=>"https://api.github.com/repos/katebeavis/pr-hero/assignees{/user}",
      #   "branches_url"=>"https://api.github.com/repos/katebeavis/pr-hero/branches{/branch}",
      #   "tags_url"=>"https://api.github.com/repos/katebeavis/pr-hero/tags",
      #   "blobs_url"=>"https://api.github.com/repos/katebeavis/pr-hero/git/blobs{/sha}",
      #   "git_tags_url"=>"https://api.github.com/repos/katebeavis/pr-hero/git/tags{/sha}",
      #   "git_refs_url"=>"https://api.github.com/repos/katebeavis/pr-hero/git/refs{/sha}",
      #   "trees_url"=>"https://api.github.com/repos/katebeavis/pr-hero/git/trees{/sha}",
      #   "statuses_url"=>"https://api.github.com/repos/katebeavis/pr-hero/statuses/{sha}",
      #   "languages_url"=>"https://api.github.com/repos/katebeavis/pr-hero/languages",
      #   "stargazers_url"=>"https://api.github.com/repos/katebeavis/pr-hero/stargazers",
      #   "contributors_url"=>"https://api.github.com/repos/katebeavis/pr-hero/contributors",
      #   "subscribers_url"=>"https://api.github.com/repos/katebeavis/pr-hero/subscribers",
      #   "subscription_url"=>"https://api.github.com/repos/katebeavis/pr-hero/subscription",
      #   "commits_url"=>"https://api.github.com/repos/katebeavis/pr-hero/commits{/sha}",
      #   "git_commits_url"=>"https://api.github.com/repos/katebeavis/pr-hero/git/commits{/sha}",
      #   "comments_url"=>"https://api.github.com/repos/katebeavis/pr-hero/comments{/number}",
      #   "issue_comment_url"=>"https://api.github.com/repos/katebeavis/pr-hero/issues/comments{/number}",
      #   "contents_url"=>"https://api.github.com/repos/katebeavis/pr-hero/contents/{+path}",
      #   "compare_url"=>"https://api.github.com/repos/katebeavis/pr-hero/compare/{base}...{head}",
      #   "merges_url"=>"https://api.github.com/repos/katebeavis/pr-hero/merges",
      #   "archive_url"=>"https://api.github.com/repos/katebeavis/pr-hero/{archive_format}{/ref}",
      #   "downloads_url"=>"https://api.github.com/repos/katebeavis/pr-hero/downloads",
      #   "issues_url"=>"https://api.github.com/repos/katebeavis/pr-hero/issues{/number}",
      #   "pulls_url"=>"https://api.github.com/repos/katebeavis/pr-hero/pulls{/number}",
      #   "milestones_url"=>"https://api.github.com/repos/katebeavis/pr-hero/milestones{/number}",
      #   "notifications_url"=>"https://api.github.com/repos/katebeavis/pr-hero/notifications{?since,all,participating}",
      #   "labels_url"=>"https://api.github.com/repos/katebeavis/pr-hero/labels{/name}",
      #   "releases_url"=>"https://api.github.com/repos/katebeavis/pr-hero/releases{/id}",
      #   "deployments_url"=>"https://api.github.com/repos/katebeavis/pr-hero/deployments",
      #   "created_at"=>1477255325,
      #   "updated_at"=>"2016-10-23T20:43:43Z",
      #   "pushed_at"=>1478195481,
      #   "git_url"=>"git://github.com/katebeavis/pr-hero.git",
      #   "ssh_url"=>"git@github.com:katebeavis/pr-hero.git",
      #   "clone_url"=>"https://github.com/katebeavis/pr-hero.git",
      #   "svn_url"=>"https://github.com/katebeavis/pr-hero",
      #   "homepage"=>nil,
      #   "size"=>844,
      #   "stargazers_count"=>0,
      #   "watchers_count"=>0,
      #   "language"=>"Ruby",
      #   "has_issues"=>true,
      #   "has_downloads"=>true,
      #   "has_wiki"=>true,
      #   "has_pages"=>false,
      #   "forks_count"=>0,
      #   "mirror_url"=>nil,
      #   "open_issues_count"=>1,
      #   "forks"=>0,
      #   "open_issues"=>1,
      #   "watchers"=>0,
      #   "default_branch"=>"master",
      #   "stargazers"=>0,
      #   "master_branch"=>"master"
      # },
      # "pusher"=>{
      #   "name"=>"katebeavis",
      #   "email"=>"katebeavis84@gmail.com"
      # },
      # "sender"=>{
      #   "login"=>"katebeavis",
      #   "id"=>10133018,
      #   "avatar_url"=>"https://avatars.githubusercontent.com/u/10133018?v=3",
      #   "gravatar_id"=>"",
      #   "url"=>"https://api.github.com/users/katebeavis",
      #   "html_url"=>"https://github.com/katebeavis",
      #   "followers_url"=>"https://api.github.com/users/katebeavis/followers",
      #   "following_url"=>"https://api.github.com/users/katebeavis/following{/other_user}",
      #   "gists_url"=>"https://api.github.com/users/katebeavis/gists{/gist_id}",
      #   "starred_url"=>"https://api.github.com/users/katebeavis/starred{/owner}{/repo}",
      #   "subscriptions_url"=>"https://api.github.com/users/katebeavis/subscriptions",
      #   "organizations_url"=>"https://api.github.com/users/katebeavis/orgs",
      #   "repos_url"=>"https://api.github.com/users/katebeavis/repos",
      #   "events_url"=>"https://api.github.com/users/katebeavis/events{/privacy}",
      #   "received_events_url"=>"https://api.github.com/users/katebeavis/received_events",
      #   "type"=>"User",
      #   "site_admin"=>false
      # },
      # "controller"=>"github_webhooks",
      # "action"=>"index",
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
      #   }],
      #   "head_commit"=>{
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
      #   },
      #   "repository"=>{
      #     "id"=>71728607,
      #     "name"=>"pr-hero",
      #     "full_name"=>"katebeavis/pr-hero",
      #     "owner"=>{
      #       "name"=>"katebeavis",
      #       "email"=>"katebeavis84@gmail.com"
      #   },
      #   "private"=>false,
      #   "html_url"=>"https://github.com/katebeavis/pr-hero",
      #   "description"=>nil,
      #   "fork"=>false,
      #   "url"=>"https://github.com/katebeavis/pr-hero",
      #   "forks_url"=>"https://api.github.com/repos/katebeavis/pr-hero/forks",
      #   "keys_url"=>"https://api.github.com/repos/katebeavis/pr-hero/keys{/key_id}",
      #   "collaborators_url"=>"https://api.github.com/repos/katebeavis/pr-hero/collaborators{/collaborator}",
      #   "teams_url"=>"https://api.github.com/repos/katebeavis/pr-hero/teams",
      #   "hooks_url"=>"https://api.github.com/repos/katebeavis/pr-hero/hooks",
      #   "issue_events_url"=>"https://api.github.com/repos/katebeavis/pr-hero/issues/events{/number}",
      #   "events_url"=>"https://api.github.com/repos/katebeavis/pr-hero/events",
      #   "assignees_url"=>"https://api.github.com/repos/katebeavis/pr-hero/assignees{/user}",
      #   "branches_url"=>"https://api.github.com/repos/katebeavis/pr-hero/branches{/branch}",
      #   "tags_url"=>"https://api.github.com/repos/katebeavis/pr-hero/tags",
      #   "blobs_url"=>"https://api.github.com/repos/katebeavis/pr-hero/git/blobs{/sha}",
      #   "git_tags_url"=>"https://api.github.com/repos/katebeavis/pr-hero/git/tags{/sha}",
      #   "git_refs_url"=>"https://api.github.com/repos/katebeavis/pr-hero/git/refs{/sha}",
      #   "trees_url"=>"https://api.github.com/repos/katebeavis/pr-hero/git/trees{/sha}",
      #   "statuses_url"=>"https://api.github.com/repos/katebeavis/pr-hero/statuses/{sha}",
      #   "languages_url"=>"https://api.github.com/repos/katebeavis/pr-hero/languages",
      #   "stargazers_url"=>"https://api.github.com/repos/katebeavis/pr-hero/stargazers",
      #   "contributors_url"=>"https://api.github.com/repos/katebeavis/pr-hero/contributors",
      #   "subscribers_url"=>"https://api.github.com/repos/katebeavis/pr-hero/subscribers",
      #   "subscription_url"=>"https://api.github.com/repos/katebeavis/pr-hero/subscription",
      #   "commits_url"=>"https://api.github.com/repos/katebeavis/pr-hero/commits{/sha}",
      #   "git_commits_url"=>"https://api.github.com/repos/katebeavis/pr-hero/git/commits{/sha}",
      #   "comments_url"=>"https://api.github.com/repos/katebeavis/pr-hero/comments{/number}",
      #   "issue_comment_url"=>"https://api.github.com/repos/katebeavis/pr-hero/issues/comments{/number}",
      #   "contents_url"=>"https://api.github.com/repos/katebeavis/pr-hero/contents/{+path}",
      #   "compare_url"=>"https://api.github.com/repos/katebeavis/pr-hero/compare/{base}...{head}",
      #   "merges_url"=>"https://api.github.com/repos/katebeavis/pr-hero/merges",
      #   "archive_url"=>"https://api.github.com/repos/katebeavis/pr-hero/{archive_format}{/ref}",
      #   "downloads_url"=>[2]
      # }
    end

    it 'has params' do
      post :payload, params: params

      expect(response.body).to eq(params)
    end
  end

end
