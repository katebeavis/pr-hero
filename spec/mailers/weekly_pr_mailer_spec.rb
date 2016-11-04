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
    it 'returns a hash of the average, max and min lead time for the last week pr' do
      expect(weekly_mailer.last_week(-2)).to eq({:avg=>2.11, :max=>4.05, :min=>0.05})
    end
  end

  describe '#two_weeks_ago' do
    xit 'returns a hash of the average, max and min lead time for two weeks ago pr' do
      expect(weekly_mailer.two_weeks_ago(-3)).to eq({:avg=>4.76, :max=>11.25, :min=>1.81})
    end
  end

  describe '#message_determiner' do
    it 'returns the correct message' do
      weekly_mailer.instance_variable_set(:@last_week_stats, {:avg=>2.11, :max=>4.05, :min=>0.05})
      weekly_mailer.instance_variable_set(:@two_weeks_ago_stats, {:avg=>4.76, :max=>11.25, :min=>1.81})
      expect(weekly_mailer.message_determiner).to eq("You did better than the previous week")
    end
  end
end
