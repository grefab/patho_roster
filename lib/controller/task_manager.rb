require_relative '../models/task'

class TaskManager
  def initialize
    @tasks = Array.new

    @tasks << Task.new(name: "registrering", cap_min: 1, cap_max: 1, workload: 1)
    @tasks << Task.new(name: "lis_makro", cap_min: 1, cap_max: 2, workload: 1)
    @tasks << Task.new(name: "bi_makro", cap_min: 1, cap_max: 2, workload: 140)
    @tasks << Task.new(name: "fremforing", cap_min: 1, cap_max: 1, workload: 1)
    @tasks << Task.new(name: "stoping", cap_min: 1, cap_max: 2, workload: 1)
    @tasks << Task.new(name: "mikro", cap_min: 2, cap_max: 6, workload: 700)
    @tasks << Task.new(name: "farging", cap_min: 1, cap_max: 1, workload: 1)
    @tasks << Task.new(name: "flyt", cap_min: 1, cap_max: 1, workload: 1)
    @tasks << Task.new(name: "bord", cap_min: 1, cap_max: 1, workload: 1)
    @tasks << Task.new(name: "immun", cap_min: 2, cap_max: 3, workload: 1)
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
