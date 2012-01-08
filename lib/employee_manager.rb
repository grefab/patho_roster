class EmployeeManager
  def initialize
    @@persistence ||= Array.new
    @employees = @@persistence
  end

  def add_employee(employee_name)
    if get_employee_by_name(employee_name) then
      -1 # this employee already exists
    else
      @employees << {:name => employee_name, :workload => 0}
      (@employees.length) -1
    end
  end

  def del_employee(employee)
    if employee.kind_of? String then
      delete_employee_by_name employee
    elsif employee.kind_of? Integer
      delete_employee_by_index employee
    else
      raise "Need an Integer or string"
    end
  end

  def delete_employee_by_name employee_name
    index = @employees.index get_employee_by_name employee_name
    delete_employee_by_index index
  end

  def delete_employee_by_index index
    @employees.delete_at index
  end

  def set_employee_workload(employee_id, workload)
    @employees[employee_id][:workload] = workload
  end

  def get_all_employees
    @employees.clone
  end

  def del_all_employees
    @employees.clear
  end

  def get_employee_by_name(employee_name)
    @employees.each do |employee|
      return employee if employee[:name] == employee_name
    end

    nil # in case we have found nothing
  end
end
