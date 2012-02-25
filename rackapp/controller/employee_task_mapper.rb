require_relative '../models/employee_task_mapping'

class EmployeeTaskMapper
  def get_mappings
    result = {}
    EmployeeTaskMapping.all.each do |e|
      result[e.employee] ||= {}
      result[e.employee][e.task] = e.workload
    end
    result
  end

  def mapping(employee, task)
    employee_task_mapping = EmployeeTaskMapping.where(employee: employee, task: task).first
    employee_task_mapping ||= EmployeeTaskMapping.create(employee: employee, task: task)

    employee_task_mapping
  end

  def get_tasks_for_employee(employee)
    result = {}
    EmployeeTaskMapping.where(employee: employee).each { |e| result[e.task] = e.workload }
    result
  end

  def reset
    EmployeeTaskMapping.delete_all
  end
end