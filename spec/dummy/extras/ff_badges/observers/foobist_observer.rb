class FfBadges::Observers::FoobistObserver < ActiveRecord::Observer

  observe :user
  
  def after_update(user)
  	if user.name_changed?
  		badge = Badge.where(name: 'Foobist').first
    	user.earn_badge!(badge) if user.deserves_badge?(badge)
    end
  end

end