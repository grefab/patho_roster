require "json"

require_relative "employee_manager"
require_relative "task_manager"
require_relative "employee_task_mapper"

class Engine
  def initialize
    @employee_manager = EmployeeManager.new
    @task_manager = TaskManager.new
    @employee_task_mapper = EmployeeTaskMapper.new
  end


  # EMPLOYEES

  def get_all_employees
    @employee_manager.get_all_employees
  end

  def add_employee employee_name
    @employee_manager.add_employee employee_name
  end

  def del_employee employee_name
    @employee_manager.del_employee employee_name
  end

  def set_employee_working employee_name, working
    @employee_manager.set_employee_working_by_name employee_name, working
  end

  def get_tasks_per_employee employee_name
    @employee_task_mapper.get_tasks_for_employee employee_name
  end

  def map_task_to_employee employee_name, task_name, workload
    @employee_task_mapper.map_task_to_employee employee_name, task_name, workload
  end

  def del_task_from_employee employee_name, task_name
    @employee_task_mapper.del_task_from_employee employee_name, task_name
  end


  # TASKS

  def get_tasks
    @task_manager.get_tasks
  end

  def set_cap_min_for_task task_name, cap_min
    @task_manager.set_cap_min task_name, cap_min
  end

  def set_cap_max_for_task task_name, cap_max
    @task_manager.set_cap_max task_name, cap_max
  end

  def set_workload_for_task task_name, workload
    @task_manager.set_workload task_name, workload
  end

  def set_value_for_task task_name, value_name, value
    case
      when value_name.to_s == "cap_min" then set_cap_min_for_task task_name, value
      when value_name.to_s == "cap_max" then set_cap_max_for_task task_name, value
      when value_name.to_s == "workload" then set_workload_for_task task_name, value
    end
  end


  # EXPORT

  def to_json
    data = {:workload_per_employees => get_workload_per_employees_for_export, :tasks => get_tasks_for_export}
    JSON.generate data
  end

  def get_workload_per_employees_for_export
    employees = @employee_manager.get_all_employees
    workload_per_employees = Array.new
    employees.each do |employee|
      if employee.working # only export working employees
        get_tasks_per_employee(employee.name).each do |task|
          workload_per_employees << {:workload_per_employee => {:name => employee.name, :task_name => task.name, :task_workload => task.workload}}
        end
      end
    end

    workload_per_employees
  end

  def get_tasks_for_export
    tasks = @task_manager.get_tasks
    tasks.inject(Array.new) do |result, task|
      result << {:task => {:name => task.name, :cap_min => task.cap_min, :cap_max => task.cap_max, :workload => task.workload}}
    end
  end

end