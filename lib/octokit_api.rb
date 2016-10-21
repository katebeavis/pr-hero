class OctokitApi

  def initialize
    @client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  end

  def user
    @client.user
  end

  def pull_requests(state='all')
    @client.auto_paginate = true
    @client.issues 'zopaUK/Helium', state: state
  end

end
