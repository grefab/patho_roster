require_relative '../models/employee'

class EmployeeManager
  def add_employee(employee_name)
    if get_employee_by_name(employee_name) then
      -1 # this employee already exists
    else
      employee = Employee.create(name: employee_name, working: true)
      Employee.count
    end
  end

  def del_employee(employee_name)
    employee = get_employee_by_name employee_name
    employee.delete
  end

  def set_employee_working_by_name(employee_name, working)
    set_working = false

    if !!working == working # .kind_of? Boolean
      set_working = working
    elsif working.kind_of? String
      set_working = working == "true"
    end

    employee = get_employee_by_name(employee_name)
    employee.working = set_working
    employee.save
  end

  def get_all_employees
    Employee.all
  end

  def reset
    Employee.delete_all
  end

  def get_employee_by_name(employee_name)
    Employee.where(name: employee_name).first
  end
end
