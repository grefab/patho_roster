set :stages, %w(production testing)
set :default_stage, "testing"
require 'capistrano/ext/multistage'

set :application, "patho_roster"
set :repository, "git://github.com/grefab/#{application}.git"
set :use_sudo, false
set :deploy_to, "/home/user/apps/#{application}"
set :scm, "git"

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/rackapp/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/rackapp/tmp/restart.txt"
  end
end