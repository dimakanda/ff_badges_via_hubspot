module FfBadges
  class Engine < ::Rails::Engine

    # it allows to run migrations without copying it to the main db/migrate folder
    # http://pivotallabs.com/leave-your-migrations-in-your-rails-engines/
    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    initializer :config_redis do
      $redis = Redis.new(host: 'localhost', port: 6379)
    end

    # adds a methods like deservers_xxxxx_badge? tomodel User 
    initializer :add_methods_for_badge_conditions do
      User.activated_badges.each do |badge_name|
        module_name = "FfBadges::Badges"

        User.send :include, "#{module_name}::#{badge_name.to_s.camelcase}".constantize
      end
    end

    initializer :add_badges_observers do |app|
      # observers defined in gem
      observers = Dir.glob(root.to_s + "/lib/ff_badges/observers/*_observer.rb")
      # observers defined in app
      observers += Dir.glob(app.root.to_s + "/extras/ff_badges/observers/*_observer.rb")

      Dir.glob(observers).each do |path|
        file = File.basename(path)
        badge_filename = file.split('_observer.rb').first

        if User.badge_activated? badge_filename
          require_dependency(path)
          ActiveRecord::Base.observers += ["FfBadges::Observers::#{badge_filename.camelcase}Observer"]
        end
      end
    end

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
      g.template_engine :erb
    end

    config.to_prepare do |c|
    end

  end
end
