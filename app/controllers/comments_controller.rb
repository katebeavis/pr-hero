require 'octokit_api'
require 'compute_comment_stats'

class CommentsController < ApplicationController
  def index
    client = OctokitApi.new
    merged_comments = client.merged_comments
    @comment_stats = ComputeCommentStats.new(merged_comments)
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Number of PR's contributed to per team member")
        f.series(name: "All time", data: @comment_stats.anonymised_contribution_data('2016-09-20T23:45:02Z'))
        f.series(name: "Last 7 days", data: @comment_stats.anonymised_contribution_data(Time.now - 1.week))

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
