class ComputePRStats

  def initialize(pull_requests)
    @pull_requests = pull_requests
    @open_pull_requests = pull_requests
  end

  def lead_time_per_pull_request
    @pull_requests.map do |p|
      {
        date: p.created_at.beginning_of_day.to_date,
        lead_time: calculate_lead_time(p.closed_at, p)
      }
    end
  end

  def open_pull_request_stats
    @open_pull_requests.map do |p|
      {
        title: p.title,
        author: p.user.login,
        lead_time: calculate_lead_time(Time.now, p).round(2)
      }
     end.sort_by { |data| data[:lead_time] }.reverse
  end

  def lead_time_per_day
    lead_time_per_pull_request.each_with_object(Hash.new(0)){|hash, totals|
      totals[hash[:date]] += hash[:lead_time]
    }
  end

  def split_by_week
    lead_time_per_day.each_with_object({}){|(k, v), week|
      week[k.cweek] ||= {}
      week[k.cweek][k] = v
    }.reverse_each.to_h
  end

  def avg
    avg_lead_time = []
    split_by_week.map do |data|
      lead_time = data[1].values
      avg = (lead_time.inject(:+) / lead_time.count).round(2)
    end
  end

  def max
    split_by_week.map { |data| data[1].values.max.round(2) }
  end

  def min
    split_by_week.map { |data| data[1].values.min.round(2) }
  end

  def earliest_pr
    @pull_requests.map{|h| h[:closed_at]}.min.to_date
  end

  private

  def calculate_lead_time(value, p)
    elapsed = (value - p.created_at)/(60 * 60 * 24)
  end
end
