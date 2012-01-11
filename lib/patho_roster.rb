require 'rubygems'
require 'sinatra'
require 'haml'
require 'uuidtools'
require 'uri'

require_relative 'engine'

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

# entry point
get '/' do
  haml :index
end



# EMPLOYEES

get '/manage_employees' do
  haml :manage_employees, :locals => {:engine => engine}
end

get '/api/add_employee' do
  employee_name = params[:employee_name]
  engine.add_employee employee_name

  response.status = 200
end

get '/api/delete_employee' do
  employee_name = params[:employee_name]

  engine.del_employee employee_name

  response.status = 200
end

get '/api/map_task_to_employee' do
  employee_name = params[:employee_name]
  task_name = params[:task_name]
  workload = params[:workload]
  engine.map_task_to_employee employee_name, task_name, workload

  response.status = 200
end

get '/api/del_task_from_employee' do
  employee_name = params[:employee_name]
  task_name = params[:task_name]
  engine.del_task_from_employee employee_name, task_name

  response.status = 200
end

get '/api/set_working_for_employee' do
  employee_name = params[:employee_name]
  working = params[:working]

  engine.set_employee_working employee_name, working

  response.status = 200
end



# TASKS

get "/manage_tasks" do
  haml :manage_tasks, :locals => {:engine => engine}
end

get '/api/set_cap_min_for_task' do
  task_name = params[:task_name]
  cap_min = params[:cap_min]
  engine.set_cap_min_for_task task_name, cap_min

  response.status = 200
end

get '/api/set_cap_max_for_task' do
  task_name = params[:task_name]
  cap_max = params[:cap_max]
  engine.set_cap_max_for_task task_name, cap_max

  response.status = 200
end

get '/api/set_workload_for_task' do
  task_name = params[:task_name]
  workload = params[:workload]
  engine.set_workload_for_task task_name, workload

  response.status = 200
end


# SOLUTIONS

get '/solve_problem' do
  input_data = engine.to_json

  File.open("../logic/input.json", 'w') {|f| f.write(input_data) }
  stdout = `cd ../logic; ./go.sh input.json`

  formatted_stdout = stdout.gsub("\n", "<br/>").gsub(" ", "&nbsp;")

  haml :solve_problem, :locals => {:output => formatted_stdout}
end

get '/show_result' do
  haml :show_result
end



# EXPORT

get '/get_exported_data' do
  engine.to_json
end