require 'spec_helper'
require 'shared_examples_for_auth'

describe 'Badges Index' do

  before do
    @administrator = create :administrator
    login_as_user @administrator

    @badge = create :badge
  end

  it_behaves_like 'normal user trying to access an admin resource' do
    let(:path_to_visit) { admin_badges_path }
  end

  it 'should show badge details' do
    within "#admin_main_nav" do
      click_link 'Badges'
    end

    within "#badges_list" do
      expect(page).to have_content @badge.name
      expect(page).to have_content @badge.description
      expect(page).to have_content @badge.message
      expect(page).to have_content @badge.points
      expect(page).to have_image @badge.icon.url(:thumb)
    end

  end

end