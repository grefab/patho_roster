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

get '/view/employees' do
  haml :manage_employees, :locals => {:engine => engine}
end

get "/view/tasks" do
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

delete '/api/employee/:name' do
  employee_name = params[:name]
  engine.del_employee employee_name

  status 200
end


# TASK MAPPING

post '/api/map/task/:employee/:task/:workload' do
  employee_name = params[:employee]
  task_name = params[:task]
  workload = params[:workload]
  engine.map_task_to_employee employee_name, task_name, workload

  status 200
end

delete '/api/map/task/:employee/:task' do
  employee_name = params[:employee]
  task_name = params[:task]
  engine.del_task_from_employee employee_name, task_name

  status 200
end

post '/api/map/working/:employee/:working' do
  employee_name = params[:employee]
  working = params[:working]
  engine.set_employee_working employee_name, working

  status 200
end


# TASKS

put '/api/task/:task/:cap_min/:cap_max/:workload' do
  name = params[:task]
  cap_min = params[:cap_min]
  cap_max = params[:cap_max]
  workload = params[:workload]
  engine.add_task name, cap_min, cap_max, workload

  status 201
end

post '/api/task/:task/:value_name/:value' do
  task_name = params[:task]
  value_name = params[:value_name]
  value = params[:value]
  engine.set_value_for_task task_name, value_name, value

  status 200
end


# EXPORT

get '/view/exported_data' do
  engine.to_json
end