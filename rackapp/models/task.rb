class Task
  def initialize content
    @name = content[:name]
    @cap_min = content[:cap_min]
    @cap_max = content[:cap_max]
    @workload = content[:workload]
  end

  attr_accessor :name
  attr_accessor :cap_min
  attr_accessor :cap_max
  attr_accessor :workload
end
