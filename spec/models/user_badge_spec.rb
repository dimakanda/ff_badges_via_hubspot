require 'spec_helper'

describe UserBadge do

  it { should belong_to(:user) }
  it { should belong_to(:badge) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:badge_id) }

end