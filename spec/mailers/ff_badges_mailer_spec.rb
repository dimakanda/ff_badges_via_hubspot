describe FfBadgesMailer, :type => :mailer do

  describe 'badge_earned_email' do

    it 'should contain correct contents' do
      user = create :user
      badge = create :badge

      mail = FfBadgesMailer.badge_earned_email(user, badge).deliver

      expect(mail.html_part.body.decoded).to include "you have earned #{badge.name} badge"
      expect(mail.html_part.body.decoded).to include badge.message
      expect(mail.subject).to eql "You have earned #{badge.name} badge."
      expect(mail.to).to eql [user.email]
    end


    it 'uses custom view for mail if defined inside views/fire_badges_mailer/badge_earned_email' do
      user = create :user
      badge = create :badge, name: 'Reviewer'

      email = FfBadgesMailer.badge_earned_email(user, badge).deliver

      raw_source = email.parts.first.body.raw_source
      expect(raw_source).to include("It's our custom email view")
    end

    it 'uses default views if not defined inside the app' do
      user = create :user
      badge = create :badge, name: 'Reviewer'
      allow_any_instance_of(FfBadgesMailer).to receive(:mail_template_path).and_return('ff_badges_mailer')

      email =  FfBadgesMailer.badge_earned_email(user, badge).deliver
      raw_source = email.parts.first.body.raw_source
      expect(raw_source).not_to include("It's our custom email view")
      expect(raw_source).to include("Congratulations, you have earned")
    end
  end

end