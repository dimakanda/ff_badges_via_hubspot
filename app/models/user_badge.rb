class UserBadge < ActiveRecord::Base

	belongs_to :user
  belongs_to :badge

	validates :user_id, :badge_id, presence: true

  after_create lambda { |record| FfBadgesMailer.badge_earned_email(record.user, record.badge).deliver }

end
