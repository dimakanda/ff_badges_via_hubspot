require 'spec_helper'

describe User do

  it { should have_many(:user_badges) }
  it { should have_many(:badges).through(:user_badges) }

  describe 'Class Methods' do

    it 'should set activated badges' do
      User.class_eval do
        badges :foobist, :barist
      end

      expect(User.activated_badges).to match_array [:foobist, :barist]

      # reload User class
      Object.send(:remove_const, 'User') 
      load 'user.rb'
    end

    describe 'activated_badges' do
      it 'should return array with activated badges list' do
        expect(User.activated_badges).to match_array [:forgetful]
      end
    end

    describe 'badge_defined?' do
      it 'should return true' do
        expect(User.badge_defined?(:forgetful)).to be true
      end

      it 'should return false' do
        expect(User.badge_defined?(:fooble)).to be false
      end
    end

    describe 'badge_activated?' do
      it 'should return true' do
        expect(User.badge_activated?(:forgetful)).to be true
      end

      it 'should return false' do
        expect(User.badge_activated?(:fooble)).to be false
      end
    end

  end

  describe 'Instance methods' do
    before :all do
      User.class_eval do

        include FfBadges::Foobist
        include FfBadges::Barist

        badges :foobist, :barist
      end
    end

    before do
      @foobist = create :badge, name: 'Foobist', filename: 'foobist'
      @barist = create :badge, name: 'Barist', filename: 'barist'
      @user = create :user, name: 'John McFoo'
    end

    describe 'deserves_badge?' do
      it 'should return true or false' do
        expect(@user.deserves_badge?(@foobist)).to be true
        expect(@user.deserves_badge?(@barist)).to be false
      end
    end

    describe 'deserves_xxxxx_badge?' do
      it 'should return true or false' do
        expect(@user.deserves_foobist_badge?).to be true
        expect(@user.deserves_barist_badge?).to be false
      end
    end

    describe 'earn_badge!' do
      it 'should add badge to user badges' do
        @user.earn_badge! @foobist

        expect(@user.badges).to include @foobist
      end
    end

    describe 'remove_badge!' do
      before do
        @user.earn_badge! @foobist
      end

      it 'should remove badge from user badges' do
        @user.remove_badge! @foobist
        expect(@user.badges.reload).not_to include(@foobist)
      end
    end

    describe 'has_badge?' do
      before do
        @user.earn_badge! @foobist
      end

      it 'should return true or false' do
        expect(@user.has_badge?(@foobist)).to be_true
        expect(@user.has_badge?(@baarist)).to be_false
      end
    end

    describe 'check_and_earn_all_badges!' do
      it 'should assing user all badges when conditions are fulfilled' do
        @user.check_and_earn_all_badges!

        expect(@user.badges).to match_array [@foobist]
      end
    end

  end

end