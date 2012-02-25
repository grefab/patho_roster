require "rspec"
require_relative "../controller/employee_task_mapper"

require "mongoid"
Mongoid.configure { |config| config.master = Mongo::Connection.new.db("patho_roster_test") }

describe "working EmployeeTaskMapper" do
  before :each do
    @employee_task_mapper = EmployeeTaskMapper.new
    @employee_task_mapper.reset
  end

  after :each do
    @employee_task_mapper.reset
  end

  it "should contain a certain list of tasks" do
    @employee_task_mapper.mapping("JohnDoe", "TestTask").set_workload(23)
    @employee_task_mapper.mapping("JohnDoe", "AnotherTestTask").set_workload(42)
    (@employee_task_mapper.get_tasks_for_employee "JohnDoe").should == {"TestTask" => 23, "AnotherTestTask" => 42}
  end

  it "should find a task list for a specific employee" do
    @employee_task_mapper.mapping("JohnDoe", "TestTask").set_workload(23)
    @employee_task_mapper.get_mappings.should == {"JohnDoe" => {"TestTask" => 23}}
  end

  it "should delete a task" do
    @employee_task_mapper.mapping("JohnDoe", "TestTask").set_workload(23)
    @employee_task_mapper.mapping("JohnDoe", "AnotherTestTask").set_workload(42)

    @employee_task_mapper.mapping("JohnDoe", "TestTask").set_workload(nil)
    @employee_task_mapper.mapping("JohnDoe", "TestTask").set_workload(nil)

    (@employee_task_mapper.get_tasks_for_employee "JohnDoe").should == {"AnotherTestTask" => 42}
  end

  it "should modify a mapping" do
    @employee_task_mapper.mapping("JohnDoe", "TestTask").set_workload(23)
    @employee_task_mapper.get_mappings.should == {"JohnDoe" => {"TestTask" => 23}}

    @employee_task_mapper.mapping("JohnDoe", "TestTask").set_workload(42)
    @employee_task_mapper.get_mappings.should == {"JohnDoe" => {"TestTask" => 42}}
  end
end
