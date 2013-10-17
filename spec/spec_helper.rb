ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../dummy/config/environment.rb",  __FILE__) # let the spec know about dummy app

require 'rspec/rails'

require 'rspec/autorun'
require 'factory_girl_rails'
require 'sorcery'
require 'paperclip/matchers'
require 'shoulda/matchers/integrations/rspec'

require 'capybara/rails'
require 'capybara/rspec'

include Sorcery::TestHelpers::Rails

Rails.backtrace_cleaner.remove_silencers!
# Load support files

Dir["#{File.dirname(__FILE__)}/support/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

include Helpers

RSpec.configure do |config|

  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.include ActionDispatch::TestProcess

  config.include FactoryGirl::Syntax::Methods

  config.include Paperclip::Shoulda::Matchers

  config.before(:suite) do
    Capybara.javascript_driver = :rack_test
  end

end

# hack for Socery, reload User model
Object.send(:remove_const, 'User')
load 'user.rb'
