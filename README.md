# FfBadges #

This project rocks and uses MIT-LICENSE.


## Installation ##

1. Add gem to the gemfile `gem 'ff_badges', git: 'git@bitbucket.org:firefield/ff_badges.git'`
2. Copy migrations `rake railties:install:migrations` and migrate
3. include the users concern in your user model `include FfBadges::UserConcern`
4. Add /extras folder to the loaded paths in your application.rb:  
   `config.autoload_paths += %W(#{config.root}/lib #{config.root}/extras)`

## Generators ##

You can use a generator which will create neccessary files for you.
Try it: `rails generate badge first_badge`

## Specs ##

Before first run you'll need to set up database for a dummy application used in specs:

* edit spec/dummy/config/database.yml
* `rake db:create`
* `RAILS_ENV=test rake db:schema:load`
