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

  def add_employee employee_name
    @employee_manager.add_employee employee_name
  end

  def del_employee employee_name
    @employee_manager.del_employee employee_name
  end

  def get_all_employees
    @employee_manager.get_all_employees
  end


  # TASKS

  def get_tasks
    @task_manager.get_tasks
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


  # EXPORT
  def to_json
    data = {:workload_per_employees => get_workload_per_employees, :tasks => get_tasks}
    JSON.pretty_generate data
  end

  def get_workload_per_employees
    employees = @employee_manager.get_all_employees
    workload_per_employees = Array.new
    employees.each do |employee|
      get_tasks_per_employee(employee[:name]).each do |task|
        workload_per_employees << {:workload_per_employee => {:name => employee[:name], :task_name => task[0], :task_workload => task[1]}}
      end
    end

    workload_per_employees
  end

  def get_tasks
    tasks = @task_manager.get_tasks
    tasks.inject(Array.new) do |result, task|
      result << {:task => {:name => task[:name], :cap_min => task[:cap_min], :cap_max => task[:cap_max], :workload => task[:workload]}}
    end
  end

end