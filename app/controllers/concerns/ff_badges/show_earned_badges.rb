module Concerns::FfBadges::ShowEarnedBadges
  extend ActiveSupport::Concern

  included do
    append_before_action :show_earned_badges
  end


  private

  def show_earned_badges
    if !!current_user && request.get? && !request.xhr? && $redis && $redis.exists("ff_badges_#{current_user.id}")
      if badge_filename = $redis.spop("ff_badges_#{current_user.id}")
        @ff_badge = Badge.where(filename: badge_filename).first
        gon.ff_badges_show_notification = true
      end
    end
  end

end