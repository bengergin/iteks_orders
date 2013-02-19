# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'thread'
require(File.join(File.dirname(__FILE__), 'config', 'boot'))


require 'rake'
require 'rake/testtask'
$LOAD_PATH.sort_by! { |p| p.match(%r[/rake\-]) ? 1 : 0 }
gem 'rdoc', ">= 2.4.2"
require 'rake/rdoctask'

require 'tasks/rails'
