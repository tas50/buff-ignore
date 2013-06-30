require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
require 'cane/rake_task'

namespace :test do
  desc 'Run quality tests'
  Cane::RakeTask.new(:quality)

  desc 'Run unit tests'
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.rspec_opts = '--color --format documentation'
  end

  task :all => [:quality, :unit]
end

desc 'Run all tests'
task :test => 'test:all'

task :default => :test
