require 'spec_helper'

describe Badge do

  it { should have_many(:users).through(:user_badges) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:icon) }
  it { should validate_presence_of(:points) }
  it { should validate_presence_of(:filename) }
  it { should have_attached_file(:icon) }
  it { should validate_numericality_of(:points).only_integer }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:filename) }

end