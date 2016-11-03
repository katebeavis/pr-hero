class HipchatApi

  def initialize
    @client = HipChat::Client.new('iWvcW2rz5nVSNuWFszKpmxjvxemWP8qJsGxVv2i1', :api_version => 'v2')
    @history = @client['3287218'].send('katebeavis', 'Wow I can\'t believe this is working')
  end

end
