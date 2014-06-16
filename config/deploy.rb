set :runner,      "icel"
set :user,        "icel"
set :application, "iteks_orders"
set :repository,  "git@github.com:bengergin/iteks_orders.git"
set :scm,         :git
set :port,        7896
default_run_options[:pty] = true


server "93.97.177.215", :app, :web, :db, :primary => true

before :deploy, "solr:stop"
after  :deploy, "solr:start"

namespace :deploy do
  desc "Restart application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :solr do
  desc "Stop the Solr server"
  task :stop, :roles => :app do
    run "#{sudo} service tomcat6  stop"
  end
  
  desc "Start the Solr server"
  task :start, :roles => :app do
    run "#{sudo} service tomcat6 start"
  end
  
  desc "Rebuild and optimize the Solr index"
  task :rebuild_and_optimize, :roles => :app do
    run "rake -f #{current_path}/Rakefile solr:rebuild_indexes RAILS_ENV=production nohup"
    run "rake -f #{current_path}/Rakefile solr:optimize RAILS_ENV=production nohup"
  end
end
