class ForgetfulObserver < ActiveRecord::Observer

  observe :user
  
  def after_update(user)
  end

end