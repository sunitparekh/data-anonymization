require 'bundler'
Bundler.setup(:default, :test)
require 'rspec/core/rake_task'
require 'tasks/rake_tasks'

Bundler::GemHelper.install_tasks
RSpec::Core::RakeTask.new(:spec)
DataAnonymization::RakeTasks.new

task :default => :spec
