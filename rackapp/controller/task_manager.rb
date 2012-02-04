require_relative '../models/task'

class TaskManager
  def initialize
    @tasks = Array.new
  end

  def add_task name, cap_min, cap_max, workload
    @tasks << Task.new(name: name, cap_min: cap_min, cap_max: cap_max, workload: workload)
  end

  def get_tasks
    @tasks
  end

  def get_task_by_name task_name
    @tasks.each { |task| return task if task.name == task_name }
    nil
  end

  def set_cap_min task_name, cap_min
    (get_task_by_name task_name).cap_min = cap_min.to_i
  end

  def set_cap_max task_name, cap_max
    (get_task_by_name task_name).cap_max = cap_max.to_i
  end

  def set_workload task_name, workload
    (get_task_by_name task_name).workload = workload.to_i
  end
end
