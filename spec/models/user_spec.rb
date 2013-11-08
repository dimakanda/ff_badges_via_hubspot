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

      # reload User model
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

    describe 'badgable_users_defined?' do
      it 'should return false' do
        expect(User.badgable_users_defined?).to be false
      end

      xit 'should return true' do
        User.instance_eval do
          scope :badgable_users, lambda { where("users.email LIKE '%foo%' ")}
        end

        expect(User.badgable_users_defined?).to be true

        class << User
          remove_method :badgable_users
        end
      end
    end

    describe 'badgable_users' do
      xit 'should return only users selected by scope' do
        user1 = create :user, email: 'frank@firefield.com'
        user2 = create :user, email: 'fox@bar.com'
        user3 = create :user, email: 'bar@firefield.com'

        User.class_eval do
          def self.badgable_users
            where("users.email LIKE '%@firefield.com'")
          end
        end

        expect(User.badgable_users).to match_array [user1, user3]

        class << User
          remove_method :badgable_users
        end
      end
    end

  end

  describe 'Instance methods' do
    before :all do
      User.class_eval do
        badges :foobist, :barist
      end
    end

    before do
      @foobist = create :badge, name: 'Foobist', filename: 'foobist', invertable: true
      @barist = create :badge, name: 'Barist', filename: 'barist', invertable: false
      @user = create :user, name: 'John McFoo'
    end

    describe 'badgable?' do
      let!(:user1) { create :user, email: 'foosky@bar.com' }
      let!(:user2) { create :user, email: 'fox@bar.com' }

      context 'Badgable users not defined' do
        it 'should return true' do
          expect(user1.badgable?).to be true
          expect(user2.badgable?).to be true
        end
      end

      context 'Badgable users defined' do
        xit 'should return true only if user fulfill conditions' do
          User.instance_eval do
            scope :badgable_users, lambda { where("users.email LIKE '%foo%' ")}
          end

          expect(user1.badgable?).to be true
          expect(user2.badgable?).to be false

          class << User
            remove_method :badgable_users
          end
        end
      end

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

      it 'should remove invertable badge from user badges' do
        @user.remove_badge! @foobist
        expect(@user.badges.reload).not_to include(@foobist)
      end

      it 'should not remove badge when its not invertable' do
        @user.remove_badge! @barist
        expect(@user.badges.reload).to include(@foobist)
      end
    end

    describe 'has_badge?' do
      before do
        @user.earn_badge! @foobist
      end

      it 'should return true or false' do
        expect(@user.has_badge?(@foobist)).to be_true
        expect(@user.has_badge?(@barist)).to be_false
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