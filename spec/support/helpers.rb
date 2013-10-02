module Helpers

  # Login as the given user filling the login form
  # @param [User] user for login
  def login_as_user(user, options={ })
    password = options[:password] || 'secret'
    user.activate! unless user.active?
    visit login_path
    fill_in 'email', :with => user.email
    fill_in 'password', :with => password
    click_button 'new_session_submit_button'
  end

  def login_as_admin(user)
    user.activate! unless user.active?
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

  # def accept_alert
  #   page.driver.browser.switch_to.alert.accept
  # end

  # def switch_back_to_main_window
  #   page.driver.browser.switch_to.window page.driver.browser.window_handles[0]
  # end

  # def switch_to_popup_window
  #   page.driver.browser.switch_to.window page.driver.browser.window_handles.last
  # end

  # def wait_for_datatable_draw(table_id)
  #   expect(page).to have_xpath "//table[@id = '#{table_id}' and @draw-finished = 'true']"
  # end

  # def pickadate(input, date)
  #   find(input).click

  #   within 'div.picker--opened' do
  #     if select_year = find('select.picker__select--year')
  #       select_year.select(date.year)
  #     end

  #     if select_month = find('select.picker__select--month')
  #       select_month.select(date.strftime("%B"))
  #     end

  #     timestamp = date.to_time.to_i * 1000

  #     find("div[data-pick = '#{timestamp}']").trigger('click')
  #   end
  # end

end