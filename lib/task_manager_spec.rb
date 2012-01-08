require "rspec"
require_relative "task_manager"

class TestTaskManager < TaskManager
end

describe "working TaskManager" do
  before :each do
    @task_manager = TaskManager.new
  end

  it "should contain a certain list of tasks" do
    @task_manager.get_task_list.should == ["registrering", "lis_makro", "bi_makro", "fremforing", "stoping", "mikro", "farging", "flyt", "bord", "immun"]
  end

  it "should be able to retrieve specific tasks by name" do
    (@task_manager.get_task_by_name "lis_makro").should == {:name => "lis_makro", :cap_min => 1, :cap_max => 2, :workload => 1}
  end

  it "should modify task values" do
    @task_manager.set_cap_min "bord", 23
    @task_manager.set_cap_max "bord", 42
    @task_manager.set_workload "bord", 666

    (@task_manager.get_task_by_name "bord").should == {:name => "bord", :cap_min => 23, :cap_max => 42, :workload => 666}
  end
end
