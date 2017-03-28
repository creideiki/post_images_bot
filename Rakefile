require 'bundler/gem_tasks'

desc 'Run Rubocop'
require 'rubocop'
require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop)

task :default => [:rubocop]
