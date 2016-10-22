class ComputePRStats

  attr_accessor :pull_requests

  def initialize(pull_requests)
    @pull_requests = pull_requests
  end

  def closed_at
    @pull_requests.map do |p|
      p.closed_at.strftime("%Y/%m/%d")
    end
  end

  def lead_time
    @pull_requests.map do |p|
      t1 = p.created_at
      t2 = p.closed_at
      elapsed = (t2 - t1)/(60 * 60 * 24)
      elapsed.round(2)
    end
  end

  # def create_data_structure
  #   pull_requests.map{|p| {"title"=>p.title { "closed_at"=>p.closed_at } } }
  # end

  def data_structure
    pull_requests.each_with_object({}) do |pull_request, h|
      h[pull_request.closed_at.strftime("%Y/%m/%d")] = { "title" => pull_request.title}
    end
  end

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
                '2016-10-08': 3.5,
                '2016-10-09': 2.0,
                '2016-10-10': 1.0,
                '2016-10-11': 5.0,
                '2016-10-12': 4.5,
                '2016-10-13': 0.0,
                '2016-10-14': 0.0
                }
    }
  end

  def max(hash)
    hash.max_by(&:last)
  end

  def days
    @days = ['yo','you',3,4,5,6,7,8]
  end
end
