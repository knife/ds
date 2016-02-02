require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

Rake::TestTask.new do |t|
  t.name = 'test:performance'
  t.libs << 'test'
  t.test_files = FileList['test/performance/*test.rb']
  t.verbose = true
end

desc 'Run tests'
task default: :test
