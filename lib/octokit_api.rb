class OctokitApi

  def initialize
    @client = Octokit::Client.new(access_token: 'b169ed958216cef15ab54543f762c20a58813a1a')
  end

  def user
    @client.user
  end

  def pull_requests
    @client.issues 'zopaUK/Helium'
  end
end
