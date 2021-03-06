require "mongoid"

class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :cap_min, type: Integer
  field :cap_max, type: Integer
  field :workload, type: Integer
end
