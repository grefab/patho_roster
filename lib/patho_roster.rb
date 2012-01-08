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

  redirect to("/manage_employees")
end

get '/api/delete_employee' do
  employee_name = params[:employee_name]

  engine.del_employee employee_name

  redirect to("/manage_employees")
end

get '/api/map_task_to_employee' do
  employee_name = params[:employee_name]
  task_name = params[:task_name]
  workload = params[:workload]
  engine.map_task_to_employee employee_name, task_name, workload

  redirect to("/manage_employees")
end

get '/api/del_task_from_employee' do
  employee_name = params[:employee_name]
  task_name = params[:task_name]
  engine.del_task_from_employee employee_name, task_name

  redirect to("/manage_employees")
end


# TASKS

get "/manage_tasks" do
  haml :manage_tasks, :locals => {:engine => engine}
end


# SOLUTIONS

get '/solve_problem' do
  haml :solve_problem
end


get '/show_result' do
  haml :show_result
end

get '/show_last_result' do
  haml :show_result
end
