require 'active_support/concern'

module Concerns::FfBadges
  extend ActiveSupport::Concern

  included do
    has_many :user_badges
    has_many :badges, through: :user_badges
 
    def self.badges(*badges)
      @@ff_badges_activated = badges.to_a

      @@ff_badges_activated.each do |badge_name|
        begin
          module_name = "FfBadges::#{badge_name.to_s.camelcase}"
          include module_name.constantize

          unless module_name.constantize.method_defined? "deserves_#{badge_name}_badge?".to_sym
            logger.error "ERROR: Define deserves_#{badge_name}_badge? method in FfBadges::#{badge_name.to_s.camelcase}."
          end

        rescue
          logger.error "ERROR: Create FfBadges::#{badge_name.to_s.camelcase} module in app/models/concerns/ff_badges/#{badge_name}.rb file."
        end
      end
    end

    def self.activated_badges
      @@ff_badges_activated
    end

  end

  def deserves_badge?(badge)
    self.send "deserves_#{badge.filename}_badge?"
  end

  def earn_badge!(badge)
    self.badges << badge if !has_badge?(badge) && deserves_badge?(badge)
  end

  def lost_badge!(badge)
    self.badges.where(badge_id: badge.id).destroy if has_badge?(badge)
  end

  def has_badge?(badge)
    self.badges.include?(badge)
  end
 
  module ClassMethods

    def badge_defined?(name)
      begin
        "FfBadges::#{name.to_s.camelcase}".constantize
        true
      rescue 
        false
      end
    end

    def badge_activated?(name)
      self.activated_badges.include? name.to_sym
    end

  end

end