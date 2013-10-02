shared_examples_for "normal user trying to access an admin resource" do

  it "should not be allowed to access the admin resource" do
    path_to_visit ||= "/admin"
    user = create(:user, email: 'foo@base_app.com')

    login_as_user user
    visit path_to_visit

    expect(current_path).to eq root_path
    expect(page).to have_content 'Sorry, only administrators can access this page'
  end

end