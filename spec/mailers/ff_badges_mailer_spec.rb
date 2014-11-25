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
  end

end