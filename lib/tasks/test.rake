namespace :test do
  desc 'Run tests with coverage'
  task :coverage do
    require 'simplecov'
    SimpleCov.start 'rails'

    Rake::Task['test'].invoke
  end
end
