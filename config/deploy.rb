set :application, "patho_roster"
set :domain, "answr.de"
set :repository, "git://github.com/grefab/#{application}.git"
set :use_sudo, false
set :deploy_to, "/home/user/apps/#{application}"
set :scm, "git"

role :app, domain
role :web, domain
role :db, domain, :primary => true

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