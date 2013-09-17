require 'cucumber/rails'
require 'cucumber/api_steps'
require 'cucumber/rspec/doubles'

require './features/support/users'

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :truncation
rescue NameError
  raise 'You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it.'
end

Cucumber::Rails::Database.javascript_strategy = :truncation

