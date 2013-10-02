require 'spec_helper'
require 'shared_examples_for_auth'

describe 'Edit badge' do

  before do
    @administrator = create :administrator
    login_as_user @administrator

    @badge = create :badge
  end

  it_behaves_like 'normal user trying to access an admin resource' do
    let(:path_to_visit) { admin_edit_badge_path(@badge) }
  end

  it 'should update badge' do
    within "#admin_main_nav" do
      click_link 'Badges'
    end

    within "#badge_#{@badge.id}" do
      click_link 'Edit'
    end
    fill_in 'Name', with: 'Bar badge'
    click_button 'Update Badge'

    expect(page).to have_notice 'Badge was successfully updated.'

    expect(page).to have_content 'Bar badge'
    expect(page).not_to have_content 'Foo badge'

  end

end