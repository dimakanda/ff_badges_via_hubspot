module Helpers

  # Login as the given user filling the login form
  # @param [User] user for login
  def login_as_user(user, options={ })
    password = options[:password] || 'secret'
    #user.activate! unless user.active?
    visit login_path
    fill_in 'email', :with => user.email
    fill_in 'password', :with => password
    click_button 'new_session_submit_button'
  end

  def login_as_admin(user)
    #user.activate! unless user.active?
    user.make_admin!
    visit "/admin"
    fill_in 'email', :with => user.email
    fill_in 'password', :with => 'secret'
    click_button 'new_session_submit_button'
  end

  def make_admin
    user = create :user
    user.make_admin!
    user
  end

  # Logout clicking in the logout link
  def logout
    click_link 'logout_link'
  end

end