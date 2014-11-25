$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ff_badges/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ff_badges"
  s.version     = FfBadges::VERSION
  s.authors     = ["Firefield"]
  s.email       = ["artur@firefield.com"]
  s.homepage    = "http://firefield.com"
  s.summary     = "Firefield Badges."
  s.description = "Firefield Badges engine with admin interface."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.8"
  s.add_dependency 'rails-observers'
  s.add_dependency "simple_form"
  s.add_dependency "redis"

  s.add_development_dependency "mysql2"

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'sorcery'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'simple_form'
  s.add_development_dependency 'shoulda-matchers'

  s.test_files = Dir["spec/**/*"]
end
