require 'rails/generators/active_record'

class BadgeGenerator < ActiveRecord::Generators::Base
  desc "Create badge definition and observer files."

  argument :name, required: true, desc: 'Badge Name', banner: 'Name'

  def self.source_root
    @source_root ||= File.expand_path('../templates', __FILE__)
  end

  def create_badge_files
    template "badge.rb.erb", "extras/ff_badges/#{badge_filename}/user_conditions.rb"
    template "observer.rb.erb", "app/observers/#{badge_filename}_observer.rb"
  end

  def show_message
    puts "\nAdd badge to User model: \n\n\s\sbadges :#{badge_filename}\n\n"
  end

  protected

  def badge_filename
    name.tableize.singularize
  end

end