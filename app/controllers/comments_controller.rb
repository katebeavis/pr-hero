require 'octokit_api'
require 'compute_comment_stats'

class CommentsController < ApplicationController
  def index
    client = OctokitApi.new
    comments = client.comments
    issue_comments = client.issue_comments
    @comment_stats = ComputeCommentStats.new(comments, issue_comments)
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Number of PR's contributed to per team member")
        f.series(name: "Team Members", data: @comment_stats.anonymised_contribution_data)

        f.yAxis [
          {title: {text: "Amount"}, min: 0, allowDecimals: false, tickInterval: 1 },
        ]
        f.xAxis [
          { type: 'category' },
        ]

        f.chart({defaultSeriesType: "column"})
    end
  end
end
