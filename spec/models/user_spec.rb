require 'spec_helper'

describe User do
  describe "validation" do
    it "should be valid with valid params" do
      User.make_unsaved.should be_valid
    end

    it "should not be valid with invalid email" do
      user = User.make_unsaved :email => 'invalid email'
      user.should_not be_valid
      user.should have_at_least(1).error_on(:email)
    end

    it "should generate username if it was blank" do
      user = User.make_unsaved :username => nil
      user.should be_valid
      user.username.should_not be_blank
    end

    User::RESERVED_USERNAMES.each do |reserved_username|
      it "should change reserved username \"#{reserved_username}\" to something else" do
        user = User.make_unsaved :username => reserved_username
        user.should be_valid
        user.username.should_not eql(reserved_username)
      end
    end

  end
end
