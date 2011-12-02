require "bundler/gem_tasks"

require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec') do |t|
  t.verbose = true    
end

task :default => :spec