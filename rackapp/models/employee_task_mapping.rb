require "mongoid"

class EmployeeTaskMapping
  include Mongoid::Document

  field :employee, type: String
  field :task, type: String
  field :workload, type: Integer
end
