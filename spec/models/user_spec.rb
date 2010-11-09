require 'spec_helper'

describe User do
  describe "validation" do
    describe "without open id" do
      def user(attributes = {})
        @user ||= returning User.make_unsaved(attributes) do |user|
          user.stub(:authenticate_with_openid?).and_return(false)
          user
        end
      end
      it "should be valid with valid params" do
        user.should be_valid
      end
      it "should not be valid with invalid email" do
        user(:email => 'invalid email').should_not be_valid
        user.should have_at_least(1).error_on(:email)
      end
      it "should not be valid if user name is blank" do
        user(:username => nil).should_not be_valid
        user.should have_at_least(1).error_on(:username)
      end
      it "should not be valid if user name is already taken" do
        user(:username => User.make.username).should_not be_valid
        user.should have_at_least(1).error_on(:username)
      end
      User::RESERVED_USERNAMES.each do |reserved_username|
        it "should not be valid if user name is reserved (\"#{reserved_username}\")" do
          user(:username => reserved_username).should_not be_valid
          user.should have_at_least(1).error_on(:username)
        end
      end
    end

    describe "with open id" do
      def user(attributes = {})
        @user ||= returning User.make_unsaved(attributes) do |user|
          user.stub(:authenticate_with_openid?).and_return(true)
          user
        end
      end
      it "should generate user name if it is blank" do
        user(:username => nil).should be_valid
        user.username.should have_at_least(3).characters
      end
      it "should change user name if it is already taken" do
        existent_user = User.make
        user(:username => existent_user.username).should be_valid
        user.username.should =~ /^#{existent_user.username} \d+$/
      end
      User::RESERVED_USERNAMES.each do |reserved_username|
        it "should generate user name if it is reserved (\"#{reserved_username}\")" do
          user(:username => reserved_username).should be_valid
          user.username.should have_at_least(3).characters
        end
      end
    end
  end

  it "should not change user name after update" do
    user = User.make
    expect {
      user.update_attribute :email, 'new@email.com'
    }.to_not change(user, :username)
  end
end
