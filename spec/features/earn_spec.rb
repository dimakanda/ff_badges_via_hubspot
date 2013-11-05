require 'spec_helper'

describe 'Earn badge', observer: 'FfBadges::Observers::ForgetfulObserver' do

  context 'Badgable users are set' do
    require_dependency('../../lib/ff_badges/observers/forgetful_observer.rb')
    ActiveRecord::Base.observers += ["FfBadges::Observers::ForgetfulObserver"]


    let!(:user1) { create :user, email: 'john@bar.com', name: 'John Cobra' }
    let!(:user2) { create :user, email: 'anne@foo.com', name: 'Anne Cobra' }
    let!(:badge) { create :badge, name: 'Forgetful', filename: 'forgetful' }

    # before :all do
    #   User.instance_eval do
    #     scope :badgable_users, lambda { where("users.email LIKE '%@foo.com' ")}
    #   end
    # end

    # after :all do
    #   class << User
    #     remove_method :badgable_users
    #   end
    # end

    xit 'should create new badge only for badgable user' do
      user1.update_attribute :reset_password_token, '123'
      user1.update_attribute :reset_password_token, nil

      user1.update_attributes name: 'John Foo'
      user2.update_attributes name: 'Anne Foo'

      expect(user1.badges).to eql []
      expect(user2.badges).to eql [badge]
    end

  end

end