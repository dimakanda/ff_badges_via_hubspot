require 'active_support/concern'

module FfBadges::UserConcern
  extend ActiveSupport::Concern

  included do
    has_many :user_badges, dependent: :destroy
    has_many :badges, through: :user_badges

    @@ff_badges_activated = []

    def self.badges(*badges)
      @@ff_badges_activated = badges.to_a

      @@ff_badges_activated.each do |badge_filename|
        begin
          module_name = "FfBadges::Badges::#{badge_filename.to_s.camelcase}"
          include module_name.constantize

          unless module_name.constantize.method_defined? "deserves_#{badge_filename}_badge?".to_sym
            logger.error "ERROR: Define deserves_#{badge_filename}_badge? method in #{module_name}"
          end

          unless module_name.constantize.method_defined? "#{badge_filename}_badge_percent".to_sym
            logger.error "ERROR: Define #{badge_filename}_badge_percent method in #{module_name}"
          end

        rescue
          logger.error "ERROR: Create module #{module_name} in #{Rails.application.class.parent_name}/extras/ff_badges/badges/#{badge_filename}.rb file."
        end
      end

      @@ff_badges_activated.each do |badge_filename|
        define_method("has_#{badge_filename}_badge?") do
          self.badgable? && self.user_badges.where(badge_filename: badge_filename).present?
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

  def badge_percent(badge)
    self.send "#{badge.filename}_badge_percent"
  end

  def earn_badge!(badge)
    if badgable? && !has_badge?(badge) && deserves_badge?(badge)
      self.add_badge!(badge)
    end
  end

  # WARNING! adds badge without checking if user deservers it or already has it
  # use only within earn_badge! or inside specs
  def add_badge!(badge)
    user_badge = self.user_badges.build
    user_badge.badge_id = badge.id
    user_badge.badge_filename = badge.filename
    user_badge.save
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