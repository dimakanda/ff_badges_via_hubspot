# FfBadges #

This project rocks and uses MIT-LICENSE.


## Installation ##

1. Add gem to the gemfile 

    `gem 'ff_badges', git: 'git@bitbucket.org:firefield/ff_badges.git'`

2. Copy migrations `rake railties:install:migrations` and migrate

3. Include the users concern in your user model `include FfBadges::UserConcern` and in your ApplicationController `include Concerns::FfBadges::ShowEarnedBadges`

4. Define a `badgeable_users` scope in your user model. For example:

    `scope :badgeable_users, -> { where.not confirmed_at: nil }`

5. Add /extras folder to the loaded paths in your application.rb:
   `config.autoload_paths += %W(#{config.root}/lib #{config.root}/extras)`

6. FFBadges require redis server. You need to start it, usually with: `redis-server`

7. You can place your custom emails for new badges notifications inside `app/views/ff_badges/badges_mailer` name them `badge_earned_email.html.erb` and `badge_earned_email.text.erb`

   You can find default views under `/app/views/ff_badges_mailer/badge_earned_email.html.erb` within the engine source.

### Badge earned modals ###
1. Add `include Concerns::FfBadges::ShowEarnedBadges` to your `application_controller.rb`

2. Add `//= require ff_badges` to your application.js

3. Call `<%= notice_earned_badges %>` within the application template or any other that you want to use.

4. You can create a partial at `extras/ff_badges/views/modal.html.erb` which will be used as a modal when user earns a badge. Default partial will be used otherwise.


### Specs helpers ###
You want to test your badges well, that's why you should add the following to your spec_helper.rb:

       include FfBadges::SpecHelpers

Thanks to this you can use: `badge_check_modal`, `badge_check_email` and `badge_check_page_content`.


## Generators ##

You can use a generator which will create neccessary files for you.
Try it: `rails generate badge first_badge`

## Specs ##

Before first run you'll need to set up database for a dummy application used in specs:

* edit spec/dummy/config/database.yml
* `rake db:create`
* `RAILS_ENV=test rake db:schema:load`


## Development ##

While using ff_badges gem within your application you may let you know the bundler that you have the gem locally. This saves time: [check this tutorial](http://ryanbigg.com/2013/08/bundler-local-paths/)