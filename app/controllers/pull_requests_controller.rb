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

  def lead_time
    @pull_requests.map do |p|
      t1 = p.created_at
      t2 = Time.now
      elapsed = (t2 - t1)/(60 * 60 * 24)
      elapsed.round(2)
    end
  end

end
