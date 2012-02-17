require "mongoid"

class Employee
  include Mongoid::Document

  field :name, type: String
  field :working, type: Boolean, default: true
end
