require 'spec_helper'

describe Badge do

  it { should have_many(:user_badges) }
  it { should have_many(:users).through(:user_badges) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:icon) }
  it { should validate_presence_of(:points) }
  it { should validate_presence_of(:filename) }
  it { should have_attached_file(:icon) }
  it { should validate_numericality_of(:points).only_integer }

  it 'should validate uniqueness of name' do
    badge = create :badge, name: 'Foo'
    badge2 = build :badge, name: 'Foo'

    expect(badge2).not_to be_valid
    expect(badge2.errors[:name]).to match_array ['has already been taken']
  end

  it 'should validate uniqueness of filename' do
    badge = create :badge, filename: 'foo'
    badge2 = build :badge, filename: 'foo'

    expect(badge2).not_to be_valid
    expect(badge2.errors[:filename]).to match_array ['has already been taken']
  end

end