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

    it "should not be valid with blank username" do
      user = User.make_unsaved :username => nil
      user.should_not be_valid
      user.should have_at_least(1).error_on(:username)
    end
  end
end
