require 'rails_helper'

RSpec.describe WeeklyPrMailer, type: :mailer do
  let(:weekly_mailer) { WeeklyPrMailer.new }
  let(:octokit) { OctokitApi.new }
  let(:pr_stats) { ComputePRStats.new(octokit.pull_requests) }
  let(:email) { described_class.weekly_pr_update_email.deliver_now }

  before do
    weekly_mailer.instance_variable_set(:@pr_stats, pr_stats)
    VCR.insert_cassette('closed_pull_requests')
  end
  after do
    VCR.eject_cassette
  end

  describe 'sending the email' do
    it 'renders the subject' do
      expect(email.subject).to eq('Weekly PR Update')
    end

    it 'renders the receiver\'s email' do
      expect(email.to).to eq(['katebeavis84@gmail.com'])
    end

    it 'renders the sender email' do
      expect(email.from).to eq(['katebeavis84@gmail.com'])
    end

    it 'assigns @message_determiner to the correct message' do
      expect(email.body.encoded).to match('You did better than the previous week')
    end
  end

  describe '#last_week' do
    it 'returns an array of the average, max and min lead time for the last week pr' do
      expect(weekly_mailer.last_week(-2)).to eq([2.11, 4.05, 0.05])
    end
  end

  describe '#two_weeks_ago' do
    it 'returns an array of the average, max and min lead time for two weeks ago pr' do
      expect(weekly_mailer.two_weeks_ago(-3)).to eq([4.76, 11.25, 1.81])
    end
  end

  describe '#message_determiner' do
    it 'returns the correct message' do
      weekly_mailer.instance_variable_set(:@last_week_stats, [4.76, 11.25, 1.81])
      weekly_mailer.instance_variable_set(:@two_weeks_ago_stats, [2.85, 5.33, 0.87])
      expect(weekly_mailer.message_determiner).to eq("You did worse than the previous week")
    end
  end
end
