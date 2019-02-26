# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  add_filter(%r{/spec/})
  coverage_dir("#{ENV.fetch('COVERAGE_DIR', 'coverage')}")
end

require 'eskimo'
require_relative './support/component_suite'

ESK = Eskimo::Components

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus

  config.disable_monkey_patching!

  config.warnings = true

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.order = :random
  config.define_derived_metadata(file_path: %r{/spec/components/}) do |metadata|
    metadata[:type] = :component
  end

  config.include EskimoTest::ComponentSuite, type: :component

  Kernel.srand config.seed
end