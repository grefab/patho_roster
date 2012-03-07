require "mongoid"

class EmployeeTaskMapping
  include Mongoid::Document
  include Mongoid::Timestamps

  field :employee, type: String
  field :task, type: String
  field :workload, type: Integer
  field :quantity, type: Integer

  def gc
    (read_attribute(:workload).nil? && read_attribute(:quantity).nil?) ? delete : save
  end

  def set_workload(workload)
    write_attributes(workload: workload)
    gc
  end

  def set_quantity(quantity)
    write_attributes(quantity: quantity)
    gc
  end
end
