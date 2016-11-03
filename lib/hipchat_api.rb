class HipchatApi

  def initialize
    @client = HipChat::Client.new(ENV['HIPCHAT_TOKEN'])
  end

end
