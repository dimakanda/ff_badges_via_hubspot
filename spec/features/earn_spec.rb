require 'spec_helper'

describe 'Earn badge', type: :feature, observer: 'FfBadges::Observers::ForgetfulObserver' do
  context 'Badgable users are set' do
    let!(:user1) { create :user, email: 'john@bar.com', name: 'John Cobra' }
    let!(:user_who_forgot) { create :user, email: 'anne@foo.com', name: 'Anne Cobra',
                                    reset_password_token: 'some', reset_password_email_sent_at: Time.now }
    let!(:badge) { create :badge, name: 'Forgetful', filename: 'forgetful' }

    it 'triggers observer method on updating instance of User' do
      expect(FfBadges::Observers::ForgetfulObserver.instance).to receive(:after_update).with(user1)
      user1.update_attributes name: 'John Foo'
    end

    it 'creates new badge only for badgable user' do
      user1.update_attribute :reset_password_token, '123'
      user_who_forgot.update_attribute :reset_password_token, nil

      expect(user1.badges).to be_empty
      expect(user_who_forgot.badges).to include badge
      expect(user_who_forgot.badges.size).to eq 1
    end

    it 'sends email to user' do
      user_who_forgot.update_attribute :reset_password_token, nil
      mail = ActionMailer::Base.deliveries.last
      expect(mail.to).to eql [user_who_forgot.email]
    end

  end

end