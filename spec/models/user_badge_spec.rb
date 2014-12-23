require 'spec_helper'

describe UserBadge, :type => :model do

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:badge) }

  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:badge_id) }

  it "Doesn't send email if skip_email passed" do
    badge = create :badge, name: 'Foobist', filename: 'foobist', invertable: true
    user = create :user, email: 'foosky@bar.com', name: 'John McFoo'

    User.class_eval do
      badges :foobist
    end

    expect(user.deserves_badge? badge).to eq true

    expect(FfBadgesMailer).to_not receive(:badge_earned_email)
    user.earn_badge! badge, skip_email: true
  end


  it 'sends email on earning badge by default' do
    badge = create :badge, name: 'Foobist', filename: 'foobist', invertable: true
    user = create :user, email: 'foosky@bar.com', name: 'John McFoo'

    User.class_eval do
      badges :foobist
    end

    expect(user.deserves_badge? badge).to eq true

    email = double 'email'
    expect(email).to receive(:deliver)
    expect(FfBadgesMailer).to receive(:badge_earned_email).and_return email
    user.earn_badge! badge
  end

  it 'handles duplicate entries gracefully' do
    badge = create :badge, name: 'Foobist', filename: 'foobist', invertable: true
    user = create :user, email: 'foosky@bar.com', name: 'John McFoo'

    User.class_eval do
      badges :foobist
    end

    expect do
      user.add_badge! badge
      user.add_badge! badge
    end.not_to raise_error

  end

end