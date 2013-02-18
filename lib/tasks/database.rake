namespace :db do
  namespace :migrate do
    
    desc "Reset the database and load in the latest data from the production server."
    task :production => [:environment, "db:drop", "db:create"] do
      ActiveRecord::Migrator.migrate("db/migrate/", File.read('PRODUCTION_DB_VERSION').to_i)

      if !File.exists?(File.join(RAILS_ROOT, "db", "dump.sql"))
        puts "No existing dump of the production database, downloading it from the server..."
        `ssh sultan ./dump_db.sh`
        `scp sultan:dump.sql #{File.join(RAILS_ROOT, "db", "dump.sql")}`
        puts "Dump downloaded."
      else
        puts "Existing dump of production database found."
      end
      
      puts "Loading dump into development database."
      `sqlite3 #{File.join(RAILS_ROOT, "db", "development.sqlite3")} < #{File.join(RAILS_ROOT, "db", "dump.sql")}`
    
      # Because Rails (for some bizarre reason) stores true differently
      # depending on your database adapter, correct this when converting from
      # MySQL to sqlite3.
      puts "Correcting boolean values for size chart specifications."
      SizeChart.find_all_by_specification(1).each do |s|
        s.update_attribute(:specification, false)
        s.update_attribute(:specification, true)
      end
      puts "Correcting boolean values for enabled users."
      User.find_all_by_enabled(1).each do |u|
        u.update_attribute(:enabled, false)
        u.update_attribute(:enabled, true)
      end
    end
    
    desc "Reset and migrate the database to the latest bleeding edge version."
    task :edge => [:production, "db:migrate"]
  end
end
