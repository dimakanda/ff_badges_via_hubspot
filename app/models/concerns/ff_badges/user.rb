require 'active_support/concern'

module Concerns::FfBadges::User
  extend ActiveSupport::Concern

  included do
    has_many :user_badges
    has_many :badges, through: :user_badges
 
    def self.badges(*badges)
      @@ff_badges_activated = badges.to_a

      @@ff_badges_activated.each do |badge_name|
        begin
          module_name = "FfBadges::Badges::#{badge_name.to_s.camelcase}"
          include module_name.constantize

          unless module_name.constantize.method_defined? "deserves_#{badge_name}_badge?".to_sym
            logger.error "ERROR: Define deserves_#{badge_name}_badge? method in #{module_name}"
          end

        rescue
          logger.error "ERROR: Create module #{module_name} in #{Rails.application.class.parent_name}/extras/ff_badges/badges/#{badge_name}.rb file."
        end
      end
    end

    def self.activated_badges
      @@ff_badges_activated
    end

  end

  def deserves_badge?(badge)
    self.send "deserves_#{badge.filename}_badge?" if badgable?
  end

  def earn_badge!(badge)
    self.badges << badge if badgable? && !has_badge?(badge) && deserves_badge?(badge) 
  end

  def remove_badge!(badge)
    if badgable? && self.has_badge?(badge) && badge.invertable?
      self.user_badges.where(badge_id: badge.id).first.destroy
    end
  end

  def has_badge?(badge)
    self.user_badges.where(badge_id: badge.id).first.present? if badgable?
  end

  def check_and_earn_all_badges!
    if badgable?
      User.activated_badges.each do |badge_name|
        self.earn_badge! Badge.where(name: badge_name).first
      end
    end
  end

  def badgable?
    !self.class.badgable_users_defined? || self.class.badgable_users.include?(self)
  end

  module ClassMethods

    def badge_defined?(name)
      begin
        "FfBadges::Badges::#{name.to_s.camelcase}".constantize
        true
      rescue
        false
      end
    end

    def badge_activated?(name)
      self.activated_badges.include? name.to_sym
    end

    def badgable_users_defined?
      self.methods.include? :badgable_users
    end

  end

end