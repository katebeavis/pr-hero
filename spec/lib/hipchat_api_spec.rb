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
end
