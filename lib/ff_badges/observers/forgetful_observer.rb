class FfBadges::Observers::ForgetfulObserver < ActiveRecord::Observer

  observe :user
  
  def after_update(user)
  	if user.reset_password_token_changed? && user.reset_password_token.nil?
  		badge = Badge.where(name: 'Forgetful').first
    	user.earn_badge!(badge) if user.deserves_badge?(badge)
    end
  end

end