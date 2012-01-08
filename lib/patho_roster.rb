require 'rubygems'
require 'sinatra'
require 'haml'
require 'uuidtools'
require 'uri'

require_relative 'employee_manager'

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


#
# ROUTES
#

# entry point
get '/' do
  haml :index
end

get '/manage_employees' do
  employee_manager = EmployeeManager.new
  haml :manage_employees, :locals => {:employees => employee_manager.get_all_employees}
end

get '/api/add_employee' do
  name = params[:employee_name]

  employee_manager = EmployeeManager.new
  id = employee_manager.add_employee name

  redirect to("/manage_employees")
end

get '/api/delete_employee' do
  employee_name = params[:employee_name]

  employee_manager = EmployeeManager.new
  employee_manager.del_employee employee_name

  redirect to("/manage_employees")
end


get '/solve_problem' do
  haml :solve_problem
end


get '/show_result' do
  haml :show_result
end

get '/show_last_result' do
  haml :show_result
end




