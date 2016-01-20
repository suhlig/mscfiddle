require 'rake/testtask'

task :default => :'test:all'

namespace :test do
  desc 'All tests'
  task :all  => ['unit', 'integration']

  task :setup do
    ENV['RACK_ENV'] = 'test'
  end

  Rake::TestTask.new(:unit => 'test:setup') do |test|
    test.libs << 'lib' << 'test' << 'test/unit'
    test.pattern = 'test/unit/test_*.rb'
  end

  Rake::TestTask.new(:integration => 'test:setup') do |test|
    test.libs << 'lib' << 'test' << 'test/unit'
    test.pattern = 'test/integration/test_*.rb'
  end
end
