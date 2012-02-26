require 'rubygems'
require 'sinatra'
require 'haml'
require 'uuidtools'
require 'uri'
require "mongoid"

Mongoid.configure { |config| config.master = Mongo::Connection.new.db("patho_roster") }

require_relative 'controller/engine'

set :server, :thin

# we need sessions and work on every interface
enable :sessions
set :bind, '0.0.0.0'

#configure cookie
use Rack::Session::Cookie, :expire_after => 1

# this is locked
#use Rack::Auth::Basic do |username, password|
#  username == 'admin' && password == 'secret'
#end

engine = Engine.new

#
# ROUTES
#

get '/' do
  haml :index
end

get '/view/employees/workload' do
  haml :manage_employees_workload, :locals => {:engine => engine}
end

get '/view/employees/quantities' do
  haml :manage_employees_quantities, :locals => {:engine => engine}
end

get '/view/tasks' do
  haml :manage_tasks, :locals => {:engine => engine}
end

get '/view/solution' do
  haml :solve_problem, :locals => {:output => engine.get_calculated_solution, :engine => engine}
end


#
# API
#

# EMPLOYEES

put '/api/employee/:name' do
  employee_name = params[:name]
  engine.add_employee employee_name

  status 201
end

post '/api/employee/:name' do
  employee_name = params[:name]

  data = JSON.parse request.body.read
  working = data["working"]

  engine.set_employee_working employee_name, working

  status 200
end

delete '/api/employee/:name' do
  employee_name = params[:name]
  engine.del_employee employee_name

  status 200
end


# MAPPING

post '/api/map/:employee/:task' do
  employee_name = params[:employee]
  task_name = params[:task]

  data = JSON.parse request.body.read
  workload = data["workload"]
  quantity = data["quantity"]

  engine.map_workload employee_name, task_name, workload if workload
  engine.map_quantity employee_name, task_name, quantity if quantity

  status 200
end

delete '/api/map/:employee/:task' do
  employee_name = params[:employee]
  task_name = params[:task]

  data = JSON.parse request.body.read
  workload = data["workload"]
  quantity = data["quantity"]

#  puts "Workload: #{workload}"
#  puts "Quantity: #{quantity}"

  engine.map_workload employee_name, task_name, nil if workload
  engine.map_quantity employee_name, task_name, nil if quantity

  status 200
end


# TASKS

put '/api/task/:task' do
  name = params[:task]

  data = JSON.parse request.body.read
  cap_min = data["cap_min"]
  cap_max = data["cap_max"]
  workload = data["workload"]

  engine.add_task name, cap_min, cap_max, workload

  status 201
end

post '/api/task/:task/:value_name' do
  task_name = params[:task]
  value_name = params[:value_name]

  data = JSON.parse request.body.read
  value = data["value"]

  engine.set_value_for_task task_name, value_name, value

  status 200
end


# EXPORT

get '/view/exported_data' do
  engine.to_json
end