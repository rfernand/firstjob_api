begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Firstjob'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Bundler::GemHelper.install_tasks

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new

task :default => :spec
task :test => :spec
task :console do
  require 'irb'
  require 'irb/completion'
  require './lib/firstjob'

  def reload!
    files = $LOADED_FEATURES.select { |feat| feat =~ %r{/firstjob/} }
    files.each { |file| load file }
  end

  load './spec/firstjob_initializer_helper.rb'

  ARGV.clear
  IRB.start
end

