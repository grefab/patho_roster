class EmployeeTaskMapper
  def initialize
    @tasks_per_employee = {}
  end

  def get_mappings
    @tasks_per_employee
  end

  def add_task_to_employee employee, task, workload
    @tasks_per_employee[employee] ||= {}
    @tasks_per_employee[employee][task] = workload
  end

  def get_tasks_for_employee employee
    @tasks_per_employee[employee]
  end

  def del_task_from_employee employee, task
    @tasks_per_employee[employee].delete task
  end
end