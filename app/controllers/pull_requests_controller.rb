require 'octokit_api'
require 'compute_pr_stats'

class PullRequestsController < ApplicationController

  def index
    client = OctokitApi.new
    @pull_requests = client.pull_requests
    @pr_stats = ComputePRStats.new(@pull_requests)
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "PR Lead Time")
        f.series(name: "Average", data: [1, 2, 5, 4.5, 1], pointStart: Time.parse("2016-09-20").getutc,
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
    # @pr_stats.lead_time
    #
    def data
      {
        week1: {
                  '2016-10-01': 3.5,
                  '2016-10-02': 2.0,
                  '2016-10-03': 1.0,
                  '2016-10-04': 5.0,
                  '2016-10-05': 4.5,
                  '2016-10-06': 0.0,
                  '2016-10-07': 0.0
                  },
        week2: {
                  '2016-10-01': 3.5,
                  '2016-10-02': 2.0,
                  '2016-10-03': 1.0,
                  '2016-10-04': 5.0,
                  '2016-10-05': 4.5,
                  '2016-10-06': 0.0,
                  '2016-10-07': 0.0
                  }
      }
    end
    # => min: 1.0
    # => avg: 3.2
    # => max: 5.0

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
