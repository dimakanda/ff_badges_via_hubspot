require 'spec_helper'
require 'shared_examples_for_auth'

describe 'Create Badge', :type => :feature do

  before do
    @administrator = create :administrator
    login_as_user @administrator
  end

  it_behaves_like 'normal user trying to access an admin resource' do
    let(:path_to_visit) { new_admin_badge_path }
  end

  it 'should create new badge' do

    within "#admin_main_nav" do
      click_link 'Badges'
    end

    click_link 'New Badge'

    fill_in 'Name', with: 'Foo badge'
    fill_in 'External unearned description', with: 'Badge External Unearned Description'
    fill_in 'External earned description', with: 'Badge External Earned Description'
    fill_in 'Internal description', with: 'Badge Internal Description'
    fill_in 'Message', with: 'Badge Message'
    fill_in 'Filename', with: 'foo_badge'
    fill_in 'Points', with: 10
    check 'User losts the badge when he stops fullfiling conditions.'
    attach_file 'Icon', File.join(Rails.root, '../', 'fixtures', 'picture.png')
    attach_file 'Inactive badge icon', File.join(Rails.root, '../', 'fixtures', 'picture.png')

    click_button 'Create Badge'

    expect(page).to have_notice 'Badge was successfully created.'
  end

end