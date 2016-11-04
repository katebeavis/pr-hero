class HipchatApi

  def initialize
    @client = HipChat::Client.new(ENV['HIPCHAT_TOKEN'], :api_version => 'v2')
  end

  def send_message(username, message, options = {})
    @client['3287218'].send(username, message, options)
  end

  def message_determiner(state, options = {})
    case state
    when "opened"
      open_pull_request(state, options)
    when "reopened"
      open_pull_request(state, options)
    when "closed" && options[:merged_at].present?
      merged_pull_request(state, options)
    end
  end

  def open_pull_request(state, options)
    self.send_message("Notifications", "Pull request #{state} by #{options[:user]} <a href=#{options[:link]}>#{options[:link]}</a>")
    #self.send_message("Notifications", "#{options[:username]} please take a look at this pull request", :message_format => "text")
  end

  def merged_pull_request(state, options)
    self.send_message("Notifications", "#{options[:title]} merged by #{options[:merged_by]} <a href=#{options[:link]}>#{options[:link]}</a>")
  end

end
