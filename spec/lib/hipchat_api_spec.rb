require 'rails_helper'
require 'hipchat_api'

RSpec.describe 'HipchatApi' do
  let(:hipchat) { HipchatApi.new }


  describe '#initialize' do
    it 'is an instance of HipchatApi' do
      expect(hipchat).to be_a(HipchatApi)
    end
  end

  describe '#send_message' do
    it 'sends a message to a hipchat room' do
      expect(hipchat).to receive(:send_message).and_return('Notifications', 'Wow!').once

      hipchat.send_message('Notifications', 'Wow!')
    end
  end

  describe '#determine_hipchat_message' do
    context 'opened pull request' do
      let(:state) { "opened" }
      let(:options) { {:user=>"katebeavis", :link=>"https://github.com/katebeavis/pr-hero/pull/10", :username=>"@TomGroombridge", :merged_at=>"", :merged_by=>nil, :title=>"fix issue with pr state"} }
      
      it 'calls the open pull request method' do
        expect(hipchat).to receive(:open_pull_request).with(state, options).once

        hipchat.determine_hipchat_message(state, options)
      end
    end

    context 'merged pull request' do
      let(:state) { "closed" }
      let(:options) { {:user=>"katebeavis", :link=>"https://github.com/katebeavis/pr-hero/pull/10", :username=>"@TomGroombridge", :merged_at=>"2016-11-05T00:29:11Z", :merged_by=>"katebeavis", :title=>"fix issue with pr state"} }
      
      it 'calls the merged pull request method' do
        expect(hipchat).to receive(:merged_pull_request).with(state, options).once

        hipchat.determine_hipchat_message(state, options)
      end
    end

    context 'closed pull request' do
      let(:state) { "closed" }
      let(:options) { {:user=>"katebeavis", :link=>"https://github.com/katebeavis/pr-hero/pull/10", :username=>"@TomGroombridge", :merged_at=>"", :merged_by=>nil, :title=>"fix issue with pr state"} }
      
      it 'does nothing' do
        expect(hipchat.determine_hipchat_message(state, options)).to eq(nil)
      end
    end
  end

  describe '#open_pull_request' do
    let(:state) { "opened" }
    let(:options) { {:user=>"katebeavis", :link=>"https://github.com/katebeavis/pr-hero/pull/10", :username=>"@TomGroombridge", :merged_at=>"", :merged_by=>nil, :title=>"fix issue with pr state"} }

    it 'calls the send message method' do
      expect(hipchat).to receive(:send_message).with("Notifications", "Pull request opened by <b>katebeavis</b> <a href=https://github.com/katebeavis/pr-hero/pull/10>https://github.com/katebeavis/pr-hero/pull/10</a>")
      expect(hipchat).to receive(:send_message).with("Notifications", "@TomGroombridge please take a look at this pull request", {:message_format=>"text"})
      hipchat.open_pull_request(state, options)
    end
  end

  describe '#merged_pull_request' do
    let(:state) { "closed" }
    let(:options) { {:user=>"katebeavis", :link=>"https://github.com/katebeavis/pr-hero/pull/10", :username=>"@TomGroombridge", :merged_at=>"2016-11-05T00:29:11Z", :merged_by=>"katebeavis", :title=>"fix issue with pr state"} }

    it 'calls the send message method' do
      expect(hipchat).to receive(:send_message).with("Notifications", "<b>fix issue with pr state</b> merged by <b>katebeavis</b> <a href=https://github.com/katebeavis/pr-hero/pull/10>https://github.com/katebeavis/pr-hero/pull/10</a>", {:color=>"green"})

      hipchat.merged_pull_request(state, options)
    end
  end
end
