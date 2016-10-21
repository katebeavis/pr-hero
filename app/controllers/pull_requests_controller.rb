require 'octokit_api'
require 'compute_pr_stats'

class PullRequestsController < ApplicationController

  def index
    client = OctokitApi.new
    @pull_requests = client.pull_requests
    @pr_stats = ComputePRStats.new(@pull_requests)
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "PR Lead Time")
        f.xAxis(categories: ['1', '2' , '3','4'])
        f.series(name: "Average", yAxis: 0, data: [1, 2])
        f.series(name: "Median", yAxis: 0, data: [1, 4])

        f.yAxis [
          {title: {text: "Time", margin: 10} },
        ]
        f.xAxis [
          {title: {text: "Days", margin: 10} },
        ]

        f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
        f.chart({defaultSeriesType: "line"})
    end
    # @pr_stats.lead_time
    # {
    #    '2016-10-01': 3.5,
    #    '2016-10-02': 2.0,
    #    ...
    # }

    # plot.lines()
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
