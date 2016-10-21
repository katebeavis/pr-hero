class ComputePRStats

  attr_accessor :pull_requests

  def initialize(pull_requests)
    @pull_requests = pull_requests
  end

  def days
    @days = ['yo','you',3,4,5,6,7,8]
  end
end
