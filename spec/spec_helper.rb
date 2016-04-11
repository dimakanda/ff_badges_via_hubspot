ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../dummy/config/environment.rb",  __FILE__) # let the spec know about dummy app

require 'rspec/rails'

require 'factory_girl_rails'
require 'sorcery'
require 'paperclip/matchers'

require 'capybara/rails'
require 'capybara/rspec'

include Sorcery::TestHelpers::Rails

Rails.backtrace_cleaner.remove_silencers!
# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
include Helpers

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.expose_current_running_example_as :example
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.include ActionDispatch::TestProcess

  config.include FactoryGirl::Syntax::Methods

  config.include Paperclip::Shoulda::Matchers
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  config.before do
    # disable all the observers
    ActiveRecord::Base.observers.disable :all

    # find out which observers this spec needs

    observers = example.metadata[:observer] || example.metadata[:observers]

    # turn on observers as needed
    if observers
      ActiveRecord::Base.observers.enable *observers
    end
  end

  config.before(:suite) do
    Capybara.javascript_driver = :rack_test
  end

end