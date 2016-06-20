class UserBadge < ActiveRecord::Base

  belongs_to :user
  belongs_to :badge

  attr_accessor :skip_email

  validates :user_id, :badge_id, presence: true
  validates_uniqueness_of :badge_id, scope: :user_id

  after_create :after_create_actions


  # User callbacks
  #----------------------------------------------------------------------
  @@user_callbacks = {}

  def self.on_creation(&block)
    @@user_callbacks[:after_create] ||= []
    @@user_callbacks[:after_create].push block
  end

  private

  def after_create_actions
    send_badge_email
    set_badge_in_redis
    add_event_badge_earn

    # Run user callbacks
    if @@user_callbacks[:after_create].present?
      @@user_callbacks[:after_create].each do |callback|
        callback.call(self)
      end
    end
  end

  def send_badge_email
    FfBadgesMailer.badge_earned_email(user, badge).deliver_now unless skip_email
  end

  def set_badge_in_redis
    $redis.sadd "ff_badges_#{self.user_id}", self.badge.filename
  end

  # TODO: Move this callback back to the project where it belongs
  def add_event_badge_earn
    if defined?(Event) == 'constant' && Event.superclass == ActiveRecord::Base #only if model Event is defined
      Event.add self.badge, 'badge_earn', self.user
    end
  end

end
