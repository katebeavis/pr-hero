require 'octokit_api'
require 'compute_pr_stats'

class PullRequestsController < ApplicationController

  def index
    client = OctokitApi.new
    @pull_requests = client.pull_requests
    # @open_pull_requests = client.pull_requests('open')
    @pr_stats = ComputePRStats.new(@pull_requests)
    @open_pr_stats = ComputePRStats.new(@open_pull_requests)
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "PR Lead Time")
        f.series(name: "Average", data: @pr_stats.avg, pointStart: @pr_stats.earliest_pr,
          pointInterval: 1.week)
        f.series(name: "Maximum", data: @pr_stats.max, pointStart: @pr_stats.earliest_pr,
          pointInterval: 1.week)
        f.series(name: "Minimum", data: @pr_stats.min, pointStart: @pr_stats.earliest_pr,
          pointInterval: 1.week)

        f.yAxis [
          {title: {text: "Lead Time (days)", margin: 10} },
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

    @chart_globals = LazyHighCharts::HighChartGlobals.new do |f|
      f.global(useUTC: false)
      f.chart(
        borderWidth: 2,
        plotBackgroundColor: "rgba(255, 255, 255, .9)",
        plotShadow: false,
        plotBorderWidth: 1
      )
      f.colors(["#0000FF", "#FF0000", "#008000", "#f15c80", "#e4d354"])
    end
  end
end
