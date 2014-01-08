require 'rails/generators/active_record'

class BadgeGenerator < ActiveRecord::Generators::Base
  desc "Create badge definition and observer files."

  argument :name, required: true, desc: 'Badge Name', banner: 'Name'
  argument :invertable, type: :string, default: false, desc: 'Badge is invertable?', banner: 'invertable'

  def self.source_root
    @source_root ||= File.expand_path('../templates', __FILE__)
  end

  def create_badge_files
    template "badge.rb.erb", "extras/ff_badges/badges/#{badge_filename}.rb"
    template "observer.rb.erb", "extras/ff_badges/observers/#{badge_filename}_observer.rb"
    template "feature_spec.rb.erb", "spec/requests/badges/#{badge_filename}_spec.rb"
  end

  def show_message
    puts "\nAdd badge to User model: \n\n\s\sbadges :#{badge_filename}\n\n"
    puts "Add following code to spec/factories.rb:\n
  factory :#{badge_filename}_badge, parent: :badge do
    name '#{name}'
    filename '#{badge_filename}'\n\n"
  end

  protected

  def badge_filename
    name.tableize.singularize.gsub(' ', '_')
  end

end