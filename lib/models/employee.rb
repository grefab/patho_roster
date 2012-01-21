class Employee
  def initialize content
    @name = content[:name]
    @working = content[:working]
  end

  attr_accessor :name
  attr_accessor :working
end
