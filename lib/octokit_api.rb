class OctokitApi

  attr_accessor :client

  def initialize
    @client = Octokit::Client.new(access_token: 'b169ed958216cef15ab54543f762c20a58813a1a')
  end

  def user
    @client.user
  end
end
