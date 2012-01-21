require_relative '../models/employee_task_mapping'

class EmployeeTaskMapper
  def initialize
    @tasks_per_employee = Array.new
  end

  def get_mappings
    result = {}
    @tasks_per_employee.each do |e|
      result[e.employee] ||= {}
      result[e.employee][e.task] = e.workload
    end
    result
  end

  def map_task_to_employee employee, task, workload
    mapping = EmployeeTaskMapping.new(employee: employee, task: task, workload: workload.to_i)
    @tasks_per_employee << mapping
  end

  def get_tasks_for_employee employee
    result = {}
    @tasks_per_employee.each { |e| result[e.task] = e.workload if e.employee == employee }
    result
  end

  def del_task_from_employee employee, task
    index = @tasks_per_employee.index { |e| e.describes_same_mapping employee, task }
    @tasks_per_employee.delete_at index if index
  end
end