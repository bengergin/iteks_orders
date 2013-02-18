set :runner,      "icel"
set :user,        "icel"
set :application, "iteks_orders"
set :repository,  "git@bitbucket.org:bengergin/iteks_orders.git"
set :scm,         :git
set :port,        7896

server "i-teks.com.tr", :app, :web, :db, :primary => true

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
    run "#{sudo} monit stop solr"
  end
  
  desc "Start the Solr server"
  task :start, :roles => :app do
    run "#{sudo} monit start solr"
  end
  
  desc "Rebuild and optimize the Solr index"
  task :rebuild_and_optimize, :roles => :app do
    run "rake -f #{current_path}/Rakefile solr:rebuild_indexes RAILS_ENV=production"
    run "rake -f #{current_path}/Rakefile solr:optimize RAILS_ENV=production"
  end
end
