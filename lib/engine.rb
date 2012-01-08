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

  def get_all_tasks
    @task_manager.get_task_list
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


end