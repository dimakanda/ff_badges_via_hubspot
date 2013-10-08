class UserBadge < ActiveRecord::Base

	belongs_to :user
  belongs_to :badge

	validates :user_id, :badge_id, presence: true

  after_create lambda { |record| FfBadgesMailer.badge_earned_email(record.user, record.badge).deliver }
  after_create :set_badge_in_redis
  after_create :add_event_badge_earn

  private

  def set_badge_in_redis
  	$redis.sadd "ff_badges_#{self.user_id}", self.badge.filename
  end

  def add_event_badge_earn
  	if defined?(Event) == 'constant' && Event.superclass == ActiveRecord::Base #only if model Event is defined
  		Event.add self.badge, 'badge_earn', self.user
  	end
  end

end
