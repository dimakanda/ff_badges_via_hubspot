require 'spec_helper'

describe Badge, :type => :model do

  it { is_expected.to have_many(:user_badges).dependent(:destroy) }
  it { is_expected.to have_many(:users).through(:user_badges) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:message) }
  it { is_expected.to validate_presence_of(:icon) }
  it { is_expected.to validate_presence_of(:icon_inactive) }
  it { is_expected.to validate_presence_of(:filename) }
  it { is_expected.to have_attached_file(:icon) }
  it { is_expected.to have_attached_file(:icon_inactive) }
  it { is_expected.to validate_numericality_of(:points).only_integer }

  it 'should validate uniqueness of name' do
    create :badge, name: 'Foo'
    badge2 = build :badge, name: 'Foo'

    expect(badge2).not_to be_valid
    expect(badge2.errors[:name]).to match_array ['has already been taken']
  end

  it 'should validate uniqueness of filename' do
    create :badge, filename: 'foo'
    badge2 = build :badge, filename: 'foo'

    expect(badge2).not_to be_valid
    expect(badge2.errors[:filename]).to match_array ['has already been taken']
  end

  it 'should validate format of filename' do
    badge1 = build :badge, filename: 'my_badge'
    badge2 = build :badge, filename: 'foobadge1'
    badge3 = build :badge, filename: 'foo-badge'

    expect(badge1).to be_valid
    expect(badge2).to be_valid
    expect(badge3).not_to be_valid
    expect(badge3.errors[:filename]).to match_array ['has wrong format']
  end

  describe 'Class Methods' do

    describe 'badge_configured?' do
      it 'should return true if badge record exists' do
        badge = create :badge, filename: 'foobarist'

        expect(Badge.badge_configured?('foobarist')).to eql true
        expect(Badge.badge_configured?('foobarista')).to eql false
      end
    end
    
  end

end