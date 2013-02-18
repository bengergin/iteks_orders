namespace :solr do
  task :rebuild_indexes => :environment do
    [ Design, Packaging, Dispatch, Sample ].each { |a| a.rebuild_solr_index(300) }
  end
  
  task :optimize => :environment do
    [ Design, Packaging, Dispatch, Sample ].each { |a| a.solr_optimize }
  end
end