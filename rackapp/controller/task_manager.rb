require_relative '../models/task'

class TaskManager
  def add_task name, cap_min, cap_max, workload
    Task.create(name: name, cap_min: cap_min, cap_max: cap_max, workload: workload)
  end

  def get_tasks
    Task.all
  end

  def get_task_by_name task_name
    Task.where(name: task_name).first
  end

  def set_cap_min task_name, cap_min
    task = get_task_by_name task_name
    task.cap_min = cap_min.to_i
    task.save
  end

  def set_cap_max task_name, cap_max
    task = get_task_by_name task_name
    task.cap_max = cap_max.to_i
    task.save
  end

  def set_workload task_name, workload
    task = get_task_by_name task_name
    task.workload = workload.to_i
    task.save
  end
end
