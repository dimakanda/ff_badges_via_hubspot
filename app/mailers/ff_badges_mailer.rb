class FfBadgesMailer < ActionMailer::Base
  default from: 'fix.me@set.from.app'
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