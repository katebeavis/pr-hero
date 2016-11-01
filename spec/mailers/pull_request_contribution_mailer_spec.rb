require "rails_helper"

RSpec.describe PullRequestContributionMailer, type: :mailer do
  let(:pull_request_mailer) { PullRequestContributionMailer.new }
  let(:octokit) { Octokit.new }
  let(:comment_stats) { ComputeCommentStats.new(octokit.merged_comments) }
  let(:email) { described_class.pull_request_contribution_email.deliver_now }

  before do
    VCR.insert_cassette('pull_request_comments')
  end
  after do
    VCR.eject_cassette
  end

  describe 'sending the email' do
    it 'renders the subject' do
      expect(email.subject).to eq('Pull request contributions per team member')
    end

    it 'renders the receiver\'s email' do
      expect(email.to).to eq(['katebeavis84@gmail.com'])
    end

    it 'renders the sender email' do
      expect(email.from).to eq(['katebeavis84@gmail.com'])
    end
  end
end
