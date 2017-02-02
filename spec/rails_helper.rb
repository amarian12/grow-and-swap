# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/rails'
require 'database_cleaner'
require 'capybara/webkit/matchers'
require 'carrierwave/test/matchers'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

session = Capybara::Session.new :webkit

Capybara.javascript_driver = :webkit
Capybara.ignore_hidden_elements = false

RSpec.configure do |config|
  # Ensure that if we are running js tests, we are using latest webpack assets
  # This will use the defaults of :js and :server_rendering meta tags
  ReactOnRails::TestHelper.configure_rspec_to_compile_assets(config)

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  config.include Rails.application.routes.url_helpers

  config.include SpecTestHelper, type: :controller

  config.include FactoryGirl::Syntax::Methods

  # Used the below DatabaseCleaner configuration based on another developers' example
  #   found online. This setup doesn't roll back the database properly

  # config.before(:suite) do
  #   begin
  #     DatabaseCleaner.start
  #     FactoryGirl.lint
  #   ensure
  #     DatabaseCleaner.clean
  #   end
  # end

  # config.before(:each) do
  #   DatabaseCleaner.strategy = :transaction
  # end

  # config.before(:each, :js => true) do
  #   DatabaseCleaner.strategy = :truncation
  # end

  # Below is an alternative DatabaseCleaner configuration recommended by the documentation
  #   This config. rolls back the database correctly after each example

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include Capybara::DSL

  config.include(Capybara::Webkit::RspecMatchers, :type => :feature)

  config.include CarrierWave::Test::Matchers

  config.before(:each) do
    allow_any_instance_of(User).to receive(:geocode) { [1, 1] }
  end
end

Capybara::Webkit.configure do |config|
  # Enable debug mode. Prints a log of everything the driver is doing.
  config.debug = true

  # By default, requests to outside domains (anything besides localhost) will
  # result in a warning. Several methods allow you to change this behavior.

  # Silently return an empty 200 response for any requests to unknown URLs.
  config.block_unknown_urls

  # Allow pages to make requests to any URL without issuing a warning.
  config.allow_unknown_urls

  # Allow a specifc domain without issuing a warning.
  config.allow_url("example.com")

  # Allow a specifc URL and path without issuing a warning.
  config.allow_url("example.com/some/path")

  # Wildcards are allowed in URL expressions.
  config.allow_url("*.example.com")

  # Silently return an empty 200 response for any requests to the given URL.
  config.block_url("example.com")

  # Timeout if requests take longer than 5 seconds
  config.timeout = 5

  # Don't raise errors when SSL certificates can't be validated
  config.ignore_ssl_errors

  # Don't load images
  config.skip_image_loading

  # Use a proxy
  # config.use_proxy(
  #   host: "example.com",
  #   port: 1234,
  #   user: "proxy",
  #   pass: "secret"
  # )
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
