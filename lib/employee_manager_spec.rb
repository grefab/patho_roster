require "rspec"
require_relative "employee_manager"

class TestEmployeeManager < EmployeeManager
end

describe "working EmployeeManager" do

  before :each do
    @employee_manager = TestEmployeeManager.new
    @employee_manager.get_all_employees.size.should == 0
  end

  after :each do
    @employee_manager.reset
    @employee_manager.get_all_employees.size.should == 0
  end

  it "should add employee" do
    (@employee_manager.add_employee "Narfzort").should == 0
    (@employee_manager.add_employee "Zortnarf").should == 1
  end

  it "should not add an employee of the same name" do
    (@employee_manager.add_employee "Narfzort").should == 0
    (@employee_manager.add_employee "Narfzort").should == -1
  end

  it "should delete an employee by name" do
    create_stub_employees

    @employee_manager.del_employee("Foobar")
    all_employees = @employee_manager.get_all_employees

    all_employees.size.should == 1
    all_employees[0].should == {:name => "Barfoo", :working => true}
  end

  it "should set workload correctly" do
    create_stub_employees

    @employee_manager.set_employee_working_by_name "Barfoo", false

    all_employees = @employee_manager.get_all_employees

    all_employees.size.should == 2
    all_employees[0].should == {:name => "Foobar", :working => true}
    all_employees[1].should == {:name => "Barfoo", :working => false}
  end

  it "should find employees by name" do
    create_stub_employees

    employee = @employee_manager.get_employee_by_name "Barfoo"

    employee.should == {:name => "Barfoo", :working => true}
  end

  it "should persist data" do
    create_stub_employees
    @employee_manager.set_employee_working_by_name "Barfoo", false

    another_employee_manager = TestEmployeeManager.new

    all_employees = another_employee_manager.get_all_employees

    all_employees.size.should == 2
    all_employees[0].should == {:name => "Foobar", :working => true}
    all_employees[1].should == {:name => "Barfoo", :working => false}
  end

  def create_stub_employees
    @employee_manager.add_employee "Foobar"
    @employee_manager.add_employee "Barfoo"
    all_employees = @employee_manager.get_all_employees

    all_employees[0].should == {:name => "Foobar", :working => true}
    all_employees[1].should == {:name => "Barfoo", :working => true}
  end

end