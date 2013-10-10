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

end