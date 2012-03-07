require "mongoid"

class Employee
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :working, type: Boolean, default: true
end
