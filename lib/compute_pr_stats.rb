class ComputePRStats

  DUMMY_DATA =      {
        week1: {
                  '2016-10-01': 3.5,
                  '2016-10-02': 2.0,
                  '2016-10-03': 1.0,
                  '2016-10-04': 5.0,
                  '2016-10-05': 4.5
                  },
        week2: {
                  '2016-10-01': 2.0,
                  '2016-10-02': 4.0,
                  '2016-10-03': 4.5,
                  '2016-10-04': 1.0,
                  '2016-10-05': 3.5
                  },
        week3: {
                  '2016-10-01': 3.5,
                  '2016-10-02': 2.0,
                  '2016-10-03': 1.0,
                  '2016-10-04': 5.0,
                  '2016-10-05': 4.5
                  }
      }

  attr_accessor :pull_requests

  def initialize(pull_requests)
    @pull_requests = pull_requests
  end

  def lead_time_per_pull_request
    pull_requests.map do |p|
      {
        :date => p.created_at.beginning_of_day.strftime("%Y-%m-%d"),
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

  def avg
    data = DUMMY_DATA
    avg_lead_time = []
    data.map do |key, value|
      lead_time = []
      value.map do |key2, value2|
        lead_time << value2
      end
      days = lead_time.length
      sum = lead_time.inject(:+)
      avg = sum / days
      avg_lead_time << avg
    end.uniq.flatten
  end

  def max
    data = DUMMY_DATA
    max_lead_time =[]
    data.map do |key, value|
      lead_time = []
      value.map do |key2, value2|
        lead_time << value2
      end
      max_lead_time << lead_time.max
    end.uniq.flatten
  end

  def min
    data = DUMMY_DATA
    min_lead_time =[]
    data.map do |key, value|
      lead_time = []
      value.map do |key2, value2|
        lead_time << value2
      end
      min_lead_time << lead_time.min
    end.uniq.flatten
  end

  private

  def calculate_lead_time(p)
    elapsed = (p.closed_at - p.created_at)/(60 * 60 * 24)
    elapsed.round(2)
  end
end
