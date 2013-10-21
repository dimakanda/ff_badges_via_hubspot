module FfBadges
  class Engine < ::Rails::Engine

    # it allows to run migrations without copying it to the main db/migrate folder
  	# http://pivotallabs.com/leave-your-migrations-in-your-rails-engines/

    config.autoload_paths << File.expand_path("../../app/observers", __FILE__)

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    initializer :add_callbacks do
    
      User.activated_badges.each do |badge_name|
        module_name = "FfBadges::Badges"

        User.send :include, "#{module_name}::#{badge_name.to_s.camelcase}".constantize
        #to_include = "#{module_name}::UserConditions".split('::').inject(Object) {|o,c| o.const_get c}
        #User.send :include, to_include

        #require Rails.root + "app/observers/ff_badges/#{badge_name}_observer.rb"

        #config.active_record.observers << "#{badge_name.to_s.camelcase}Observer"
        #config.active_record.observers += ["#{badge_name}_observer".to_sym]
      end

      #ActiveRecord::Base.instantiate_observers
    end

    initializer :config_redis do
      $redis = Redis.new(host: 'localhost', port: 6379)
    end

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
      g.template_engine :erb
    end

    config.to_prepare do
      # Dir.glob(Rails.root + "app/observers/ff_badges/*.rb").each do |c|
      #   if User.badge_defined?(c)
      #     require_dependency(c)
      #   end
      # end

      # Dir.glob(Rails.root + "app/models/concerns/ff_badges/*.rb").each do |c|
      #   require_dependency(c)
      # end
    end

  end
end
