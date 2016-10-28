require 'octokit_api'
require 'compute_comment_stats'

class CommentsController < ApplicationController
  def index
    client = OctokitApi.new
    pull_requests = client.pull_requests
    @comment_stats = ComputeCommentStats.new(pull_requests)
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Number of PR's contributed to per team member")
        f.series(name: "Team Members", data: [['A', 5], ['B', 6], ['C', 8], ['D', 12]], tickInterval: 1)

        f.yAxis [
          {title: {text: "Number"}, min: 0, allowDecimals: false, tickInterval: 1 },
        ]
        f.xAxis [
          { type: 'category' },
        ]

        f.chart({defaultSeriesType: "column"})
    end
  end
end
