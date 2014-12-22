class UserBadge < ActiveRecord::Base

  belongs_to :user
  belongs_to :badge

  attr_accessor :skip_email

  validates :user_id, :badge_id, :badge_filename, presence: true
  validates_uniqueness_of :badge_id, scope: :user_id

  after_create :send_badge_email
  after_create :set_badge_in_redis
  after_create :add_event_badge_earn

  private

  def send_badge_email
    FfBadgesMailer.badge_earned_email(user, badge).deliver unless skip_email
  end

  def set_badge_in_redis
    $redis.sadd "ff_badges_#{self.user_id}", self.badge.filename
  end

  def add_event_badge_earn
    if defined?(Event) == 'constant' && Event.superclass == ActiveRecord::Base #only if model Event is defined
      Event.add self.badge, 'badge_earn', self.user
    end
  end

end
