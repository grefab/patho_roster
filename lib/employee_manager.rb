class EmployeeManager
  def initialize
    @@persistence ||= Array.new
    @employees = @@persistence
  end

  def add_employee(employee_name)
    if get_employee_by_name(employee_name) then
      -1 # this employee already exists
    else
      @employees << {:name => employee_name, :working => true}
      (@employees.length) -1
    end
  end

  def del_employee(employee_name)
    index = @employees.index get_employee_by_name employee_name
    @employees.delete_at index
  end

  def set_employee_working_by_name(employee_name, working)
    set_working = false

    if !!working == working # .kind_of? Boolean
      set_working = working
    elsif working.kind_of? String
      set_working = working == "true"
    end

    get_employee_by_name(employee_name)[:working] = set_working
  end

  def get_all_employees
    @employees.clone
  end

  def reset
    @employees.clear
  end

  def get_employee_by_name(employee_name)
    @employees.each { |employee| return employee if employee[:name] == employee_name }
    nil
  end

end
