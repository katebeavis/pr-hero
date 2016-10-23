require 'octokit_api'
require 'compute_pr_stats'

class PullRequestsController < ApplicationController

  def index
    client = OctokitApi.new
    @pull_requests = client.pull_requests
    @pr_stats = ComputePRStats.new(@pull_requests)
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "PR Lead Time")
        f.series(name: "Average", data: @pr_stats.avg, pointStart: Time.parse("2016-09-20").getutc,
          pointInterval: 1.week)
        f.series(name: "Maximum", data: @pr_stats.max, pointStart: Time.parse("2016-09-20").getutc,
          pointInterval: 1.week)
        f.series(name: "Minimum", data: @pr_stats.min, pointStart: Time.parse("2016-09-20").getutc,
          pointInterval: 1.week)

        f.yAxis [
          {title: {text: "Lead Time", margin: 10} },
        ]
        f.xAxis [
          { type: 'datetime',
            title: {text: "Date", margin: 10},
            dateTimeLabelFormats: {week: 'wb %e/%m'},
          },
        ]

        f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
        f.chart({defaultSeriesType: "line"})
    end
  end
end
