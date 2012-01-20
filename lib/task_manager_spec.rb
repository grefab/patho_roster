require "rspec"
require_relative "task_manager"

class TestTaskManager < TaskManager
end

describe "working TaskManager" do
  before :each do
    @task_manager = TaskManager.new
  end

  it "should contain a certain list of tasks" do
    task_list = @task_manager.get_tasks.inject(Array.new) { |result, task| result << task.name }
    task_list.should == ["registrering", "lis_makro", "bi_makro", "fremforing", "stoping", "mikro", "farging", "flyt", "bord", "immun"]
  end

  it "should be able to retrieve specific tasks by name" do
    (@task_manager.get_task_by_name "lis_makro").name.should == "lis_makro"
    (@task_manager.get_task_by_name "lis_makro").cap_min.should == 1
    (@task_manager.get_task_by_name "lis_makro").cap_max.should == 2
    (@task_manager.get_task_by_name "lis_makro").workload.should == 1
  end

  it "should modify task values" do
    @task_manager.set_cap_min "bord", 23
    @task_manager.set_cap_max "bord", 42
    @task_manager.set_workload "bord", 666

    (@task_manager.get_task_by_name "bord").name.should == "bord"
    (@task_manager.get_task_by_name "bord").cap_min.should == 23
    (@task_manager.get_task_by_name "bord").cap_max.should == 42
    (@task_manager.get_task_by_name "bord").workload.should == 666
  end
end
