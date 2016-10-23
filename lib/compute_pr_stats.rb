class ComputePRStats

  def initialize(pull_requests)
    @pull_requests = pull_requests
  end

  def lead_time_per_pull_request
    @pull_requests.map do |p|
      {
        :date => p.created_at.beginning_of_day.to_date,
        :lead_time => calculate_lead_time(p)
      }
    end
  end

  def lead_time_per_day
    totals = Hash.new(0)
    lead_time_per_pull_request.each { |data| totals[data[:date]] += data[:lead_time] }
    totals
  end

  def split_by_week
    week = Hash.new(0)
    lead_time_per_day.each do |data|
      week[data.first.cweek] = {} unless week[data.first.cweek] != 0
      week[data.first.cweek][data.first] = data.last
    end
    week.reverse_each.to_h
  end

  def avg
    avg_lead_time = []
    split_by_week.map do |data|
      lead_time = data[1].values
      avg = (lead_time.inject(:+) / lead_time.count).round(2)
    end
  end

  def max
    split_by_week.map { |data| max_lead_time = data[1].values.max.round(2) }
  end

  def min
    split_by_week.map { |data| min_lead_time = data[1].values.min.round(2) }
  end

  private

  def calculate_lead_time(p)
    elapsed = (p.closed_at - p.created_at)/(60 * 60 * 24)
  end
end
