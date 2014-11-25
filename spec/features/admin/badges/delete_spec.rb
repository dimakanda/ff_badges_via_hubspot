require 'spec_helper'
require 'shared_examples_for_auth'

describe 'Delete badge', :type => :feature do

  before do
    @administrator = create :administrator
    login_as_user @administrator

    @badge = create :badge, name: 'Foo badge'
  end

  it 'should update badge' do
    within "#admin_main_nav" do
      click_link 'Badges'
    end

    within "#badge_#{@badge.id}" do
      click_link 'Destroy'
    end

    expect(page).to have_notice 'Badge was successfully destroyed.'
    expect(page).not_to have_content 'Foo badge'
  end

end