class EmployeeTaskMapping
  attr_accessor :employee
  attr_accessor :task
  attr_accessor :workload

  def initialize content
    @employee = content[:employee]
    @task = content[:task]
    @workload = content[:workload]
  end

  def describes_same_mapping employee, task
    @employee == employee && @task == task
  end
end
