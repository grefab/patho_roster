require 'rubygems'
require 'sinatra'
require 'haml'
require 'uuidtools'
require 'uri'

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

# entry point
get '/' do
  haml :index
end


# EMPLOYEES

get '/view/employees' do
  haml :manage_employees, :locals => {:engine => engine}
end

put '/api/employee/:name' do
  employee_name = params[:name]
  engine.add_employee employee_name

  halt 200
end

delete '/api/employee/:name' do
  employee_name = params[:name]
  engine.del_employee employee_name

  halt 200
end


# TASK MAPPING

post '/api/map/task/:employee/:task/:workload' do
  employee_name = params[:employee]
  task_name = params[:task]
  workload = params[:workload]
  engine.map_task_to_employee employee_name, task_name, workload

  halt 200
end

delete '/api/map/task/:employee/:task' do
  employee_name = params[:employee]
  task_name = params[:task]
  engine.del_task_from_employee employee_name, task_name

  halt 200
end

post '/api/map/working/:employee/:working' do
  employee_name = params[:employee]
  working = params[:working]
  engine.set_employee_working employee_name, working

  halt 200
end


# TASKS

get "/view/tasks" do
  haml :manage_tasks, :locals => {:engine => engine}
end

put '/api/task/:task/:cap_min/:cap_max/:workload' do
  name = params[:task]
  cap_min = params[:cap_min]
  cap_max = params[:cap_max]
  workload = params[:workload]
  engine.add_task name, cap_min, cap_max, workload

  halt 200
end

post '/api/task/:task/:value_name/:value' do
  task_name = params[:task]
  value_name = params[:value_name]
  value = params[:value]
  engine.set_value_for_task task_name, value_name, value

  halt 200
end


# SOLUTIONS

get '/view/solution' do
  input_data = engine.to_json
  File.open("../logic/input.json", 'w') { |f| f.write(input_data) }
  stdout = `cd ../logic; ./go.sh input.json`
  raw_solution = stdout #.gsub("\n", "<br/>").gsub(" ", "&nbsp;")

  begin
    parsed_solution = JSON.parse raw_solution

    cells = {}
    parsed_solution["cells"].each do |value|
      c = value["cell"]
      cells[{:employee => c["name"], :task => c["task"]}] = c["work_amount"]
    end

    sum_row = {}
    parsed_solution["sum_row"].each do |value|
      c = value["sum_cell"]
      sum_row[c["task"].to_sym] = c["sum_work"]
    end

    final_data = {:cells => cells, :sum_row => sum_row}
  rescue
    final_data = {}
  end

  haml :solve_problem, :locals => {:output => final_data, :engine => engine}
end

get '/view/result' do
  haml :show_result
end


# EXPORT

get '/view/exported_data' do
  engine.to_json
end