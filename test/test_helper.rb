require 'simplecov'
require 'simplecov_json_formatter'
require 'simplecov-material'

SimpleCov.start(:rails) do
  filters.clear
  add_filter '/app/channels'
  add_filter '/app/javascripts'
  add_filter '/app/jobs'
  add_filter '/app/mailers'
  add_filter '/test'
  add_filter '/config'

  minimum_coverage 80
  formatter SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::SimpleFormatter,
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::JSONFormatter,
    SimpleCov::Formatter::MaterialFormatter
  ]
                                                    )
end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  include FactoryBot::Syntax::Methods

  # Add more helper methods to be used by all tests here...
end
