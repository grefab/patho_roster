require "rspec"
require_relative "employee_task_mapper"

describe "working EmployeeTaskMapper" do
  before :each do
    @employee_task_mapper = EmployeeTaskMapper.new
  end

  it "should contain a certain list of tasks" do
    @employee_task_mapper.map_task_to_employee "JohnDoe", "TestTask", 23
    @employee_task_mapper.map_task_to_employee "JohnDoe", "AnotherTestTask", 42
    (@employee_task_mapper.get_tasks_for_employee "JohnDoe").should == {"TestTask" => 23, "AnotherTestTask" => 42}
  end

  it "should find a task list for a specific employee" do
    @employee_task_mapper.map_task_to_employee "JohnDoe", "TestTask", 23
    @employee_task_mapper.get_mappings.should == {"JohnDoe" => {"TestTask" => 23}}
  end

  it "should delete a task" do
    @employee_task_mapper.map_task_to_employee "JohnDoe", "TestTask", 23
    @employee_task_mapper.map_task_to_employee "JohnDoe", "AnotherTestTask", 42

    @employee_task_mapper.del_task_from_employee "JohnDoe", "TestTask"

    (@employee_task_mapper.get_tasks_for_employee "JohnDoe").should == {"AnotherTestTask" => 42}
  end

  it "should modify a mapping" do
    @employee_task_mapper.map_task_to_employee "JohnDoe", "TestTask", 23
    @employee_task_mapper.get_mappings.should == {"JohnDoe" => {"TestTask" => 23}}

    @employee_task_mapper.map_task_to_employee "JohnDoe", "TestTask", 42
    @employee_task_mapper.get_mappings.should == {"JohnDoe" => {"TestTask" => 42}}
  end
end