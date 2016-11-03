class HipchatApi

  def initialize
    @client = HipChat::Client.new(ENV['HIPCHAT_TOKEN'], :api_version => 'v2')
  end

  def send_message(username, message)
    @client['3287218'].send(username, message)
  end

end
