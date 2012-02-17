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

  def map_task_to_employee(employee, task, workload)
    EmployeeTaskMapping.create(employee: employee, task: task, workload: workload.to_i)
  end

  def get_tasks_for_employee(employee)
    result = {}
    EmployeeTaskMapping.where(employee: employee).each { |e| result[e.task] = e.workload }
    result
  end

  def del_task_from_employee(employee, task)
    employee_task_mapping = EmployeeTaskMapping.where(employee: employee, task: task).first
    employee_task_mapping.delete if employee_task_mapping
  end

  def reset
    EmployeeTaskMapping.delete_all
  end
end