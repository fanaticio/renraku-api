require 'support/matchers/delegates_matcher'
require 'support/matchers/attr_accessor_matcher'
require 'support/shared_examples/models/classic'
require 'support/shared_examples/presenters/api/error_presenter'
require 'support/shared_examples/services/api/service'

RSpec.configure do |config|
  config.alias_example_to :expect_it
  config.order = 'random'
  config.treat_symbols_as_metadata_keys_with_true_values = true

  if config.filter_manager.inclusions.has_key?(:rails)
    config.filter_manager.inclusions.delete(:rails)
    require 'rails_spec_helper'
  else
    config.filter_run_excluding rails: true
  end

  config.expect_with :rspec do |expect_config|
    expect_config.syntax = :expect
  end
end

RSpec::Core::MemoizedHelpers.module_eval do
  alias to should
  alias to_not should_not
end
