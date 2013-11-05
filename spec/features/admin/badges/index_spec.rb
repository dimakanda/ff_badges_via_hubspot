require 'spec_helper'
require 'shared_examples_for_auth'

describe 'Badges Index' do

  before do
    @administrator = create :administrator
    login_as_user @administrator
  end

  it_behaves_like 'normal user trying to access an admin resource' do
    let(:path_to_visit) { admin_badges_path }
  end

  it 'should show badge details' do
    badge1 = create :badge, name: 'Forgetful', filename: 'forgetful'
    badge2 = create :badge

    within "#admin_main_nav" do
      click_link 'Badges'
    end

    within "#badge_#{badge1.id}" do
      expect(page).to have_content badge1.name
      expect(page).to have_content badge1.description
      expect(page).to have_content badge1.message
      expect(page).to have_content badge1.points
      expect(page).to have_image badge1.icon.url(:thumb)
      expect(page).to have_content 'defined'
      expect(page).to have_content 'activated'
    end

    within "#badge_#{badge2.id}" do
      expect(page).to have_content badge2.name
      expect(page).to have_content badge2.description
      expect(page).to have_content badge2.message
      expect(page).to have_content badge2.points
      expect(page).to have_image badge2.icon.url(:thumb)
      expect(page).to have_content 'not defined'
    end

  end

  it 'should show notice that some badges are defined but not configured' do
    User.class_eval do
      badges :foobist, :barist
    end

    click_link 'Badges'

    expect(page).to have_content 'Following badges have been defined and activated but not configured: Foobist, Barist'

    # reload User class
    Object.send(:remove_const, 'User') 
    load 'user.rb'
  end

  it 'should show notice that badges are enabled only to selected users' do
    User.class_eval do
      scope :badgable_users, lambda { where("users.email LIKE '%@bar.com' ")}
    end

    user1 = create :user, email: 'foosky@bar.com'
    user2 = create :user, email: 'barsky@bar.com'
    user3 = create :user, email: 'bar@foo.com'

    click_link 'Badges'

    within '#badgable_users_info' do
      expect(page).to have_content 'Badges are avaliable only for the following users:'
      expect(page).to have_content 'foosky@bar.com'
      expect(page).to have_content 'barsky@bar.com'
      expect(page).not_to have_content 'bar@foo.com'
    end

    # reload User class
    Object.send(:remove_const, 'User') 
    load 'user.rb'
  end

end