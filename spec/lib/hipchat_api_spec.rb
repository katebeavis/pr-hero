require 'rails_helper'
require 'hipchat_api'

RSpec.describe 'HipchatApi' do
  let(:hipchat) { HipchatApi.new }

  it 'is an instance of HipchatApi' do
    expect(hipchat).to be_a(HipchatApi)
  end
end
