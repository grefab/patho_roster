class EmployeeManager
  def initialize
    @@persistence ||= Array.new
    @@next_id ||= 0
    @employees = @@persistence
  end

  def get_next_id
    next_id = @@next_id
    @@next_id += 1
    next_id
  end

  def add_employee(employee_name)
    if get_employee_by_name(employee_name) then
      -1 # this employee already exists
    else
      @employees << {:name => employee_name, :workload => 0, :id => get_next_id}
      @employees.last[:id]
    end
  end

  def del_employee(employee)
    if employee.kind_of? String then
      delete_employee_by_name employee
    elsif employee.kind_of? Integer
      delete_employee_by_id employee
    else
      raise "Need an Integer or string"
    end
  end

  def delete_employee_by_name employee_name
    index = @employees.index get_employee_by_name employee_name
    @employees.delete_at index
  end

  def delete_employee_by_id employee_id
    index = @employees.index get_employee_by_id employee_id
    @employees.delete_at index
  end

  def set_employee_workload_by_name(employee_name, workload)
    get_employee_by_name(employee_name)[:workload] = workload
  end

  def get_all_employees
    @employees.clone
  end

  def reset
    @employees.clear
    @@next_id = 0
  end

  def get_employee_by_name(employee_name)
    @employees.each do |employee|
      return employee if employee[:name] == employee_name
    end

    nil # in case we have found nothing
  end

  def get_employee_by_id(employee_id)
    @employees.each do |employee|
      return employee if employee[:id] == employee_id
    end

    nil # in case we have found nothing
  end
end
