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

  halt 200
end

get '/api/delete_employee' do
  employee_name = params[:employee_name]

  engine.del_employee employee_name

  halt 200
end

get '/api/map_task_to_employee' do
  employee_name = params[:employee_name]
  task_name = params[:task_name]
  workload = params[:workload]
  engine.map_task_to_employee employee_name, task_name, workload

  halt 200
end

get '/api/del_task_from_employee' do
  employee_name = params[:employee_name]
  task_name = params[:task_name]
  engine.del_task_from_employee employee_name, task_name

  halt 200
end

get '/api/set_working_for_employee' do
  employee_name = params[:employee_name]
  working = params[:working]

  engine.set_employee_working employee_name, working

  halt 200
end



# TASKS

get "/manage_tasks" do
  haml :manage_tasks, :locals => {:engine => engine}
end

get '/api/set_value_for_task' do
  task_name = params[:task_name]
  value_name = params[:value_name]
  value = params[:value]
  engine.set_value_for_task task_name, value_name, value

  halt 200
end



# SOLUTIONS

get '/solve_problem' do
  input_data = engine.to_json
  File.open("../logic/input.json", 'w') {|f| f.write(input_data) }
  stdout = `cd ../logic; ./go.sh input.json`
  raw_solution = stdout #.gsub("\n", "<br/>").gsub(" ", "&nbsp;")

=begin
  raw_solution = '
{"cells":[{"cell":{"name":"asfl","task":"mikro","work_amount":"14 (280)"}},
{"cell":{"name":"beno","task":"bord","work_amount":"1 (1)"}},
{"cell":{"name":"brha","task":"immun","work_amount":"0 (1)"}},
{"cell":{"name":"eiij","task":"immun","work_amount":"0 (1)"}},
{"cell":{"name":"fhilde","task":"registrering","work_amount":"1 (1)"}},
{"cell":{"name":"firene","task":"immun","work_amount":"0 (1)"}},
{"cell":{"name":"hldr","task":"mikro","work_amount":"10 (200)"}},
{"cell":{"name":"iklu","task":"bi_makro","work_amount":"70 (70)"}},
{"cell":{"name":"inyh","task":"farging","work_amount":"1 (1)"}},
{"cell":{"name":"irsl","task":"stoping","work_amount":"1 (1)"}},
{"cell":{"name":"kimuls","task":"fremforing","work_amount":"1 (1)"}},
{"cell":{"name":"leew","task":"mikro","work_amount":"10 (200)"}},
{"cell":{"name":"lleh","task":"flyt","work_amount":"1 (1)"}},
{"cell":{"name":"lsiw","task":"lis_makro","work_amount":"1 (1)"}},
{"cell":{"name":"mainas","task":"mikro","work_amount":"10 (200)"}},
{"cell":{"name":"ny","task":"lis_makro","work_amount":"1 (1)"}},
{"cell":{"name":"rabr","task":"mikro","work_amount":"10 (200)"}},
{"cell":{"name":"sape","task":"mikro","work_amount":"14 (280)"}},
{"cell":{"name":"uahe","task":"stoping","work_amount":"1 (1)"}},
{"cell":{"name":"ulan","task":"bi_makro","work_amount":"70 (70)"}}],
"sum_row":[{"sum_cell":{"task":"registrering","sum_work":"1 (100%)"}},{"sum_cell":{"task":"lis_makro","sum_work":"2 (200%)"}},{"sum_cell":{"task":"bi_makro","sum_work":"140 (100%)"}},{"sum_cell":{"task":"fremforing","sum_work":"1 (100%)"}},{"sum_cell":{"task":"stoping","sum_work":"2 (200%)"}},{"sum_cell":{"task":"mikro","sum_work":"1360 (1943%)"}},{"sum_cell":{"task":"farging","sum_work":"1 (100%)"}},{"sum_cell":{"task":"flyt","sum_work":"1 (100%)"}},{"sum_cell":{"task":"bord","sum_work":"1 (100%)"}},{"sum_cell":{"task":"immun","sum_work":"3 (300%)"}}
]}
';
=end

  parsed_solution = JSON.parse raw_solution

  cells = {}
  parsed_solution["cells"].each do |value|
    c = value["cell"]
    cells[{:employee => c["name"], :task => c["task"]} ] = c["work_amount"]
  end

  sum_row = {}
  parsed_solution["sum_row"].each do |value|
    c = value["sum_cell"]
    sum_row[c["task"].to_sym] = c["sum_work"]
  end

  final_data = {:cells => cells, :sum_row => sum_row}

  haml :solve_problem, :locals => {:output => final_data, :engine => engine}
end

get '/show_result' do
  haml :show_result
end



# EXPORT

get '/get_exported_data' do
  engine.to_json
end