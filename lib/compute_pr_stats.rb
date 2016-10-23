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
    lead_time_per_pull_request.each do |data|
      totals[data[:date]] += data[:lead_time]
    end
    totals
  end

  def split_by_week
    by_week = Hash.new(0)
    lead_time_per_day.each do |d, v|
      if by_week[d.cweek] == 0
        by_week[d.cweek] = {}
        by_week[d.cweek][d] = v
      else
        by_week[d.cweek][d] = v
      end
    end
    by_week.reverse_each.to_h
  end

  def avg
    avg_lead_time = []
    split_by_week.map do |key, value|
      lead_time = []
      value.map do |key2, value2|
        lead_time << value2
      end
      days = lead_time.length
      sum = lead_time.inject(:+)
      avg = sum / days
      avg_lead_time << avg.round(2)
    end.uniq.flatten
  end

  def max
    max_lead_time =[]
    split_by_week.map do |key, value|
      lead_time = []
      value.map do |key2, value2|
        lead_time << value2
      end
      max_lead_time << lead_time.max.round(2)
    end.uniq.flatten
  end

  def min
    min_lead_time =[]
    split_by_week.map do |key, value|
      lead_time = []
      value.map do |key2, value2|
        lead_time << value2
      end
      min_lead_time << lead_time.min.round(2)
    end.uniq.flatten
  end

  private

  def calculate_lead_time(p)
    elapsed = (p.closed_at - p.created_at)/(60 * 60 * 24)
    elapsed
  end
end
