class FfBadgesMailer < ActionMailer::Base
  default from: ENV.has_key?('DEFAULT_FROM_EMAIL') ? ENV['DEFAULT_FROM_EMAIL'] : 'change.me@email.com'
  layout 'email'

  def badge_earned_email(user, badge)
    @user = user
    if @user.badgable?
       @badge = badge
      @user_badge = UserBadge.where(user_id: @user, badge_id: @badge).first
      mail to: @user.email, subject: "You have earned #{@badge.name} badge."
    end
  end

end