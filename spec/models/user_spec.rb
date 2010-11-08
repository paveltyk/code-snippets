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

    it "should not be valid if user name is blank" do
      user = User.make_unsaved :username => nil
      user.should_not be_valid
      user.should have_at_least(1).error_on(:username)
    end

    it "should not be valid if user name is already taken" do
      u1 = User.make
      u2 = User.make_unsaved :username => u1.username
      u2.should_not be_valid
      u2.should have_at_least(1).error_on(:username)
    end

    User::RESERVED_USERNAMES.each do |reserved_username|
      it "should not be valid if user name is reserved (\"#{reserved_username}\")" do
        user = User.make_unsaved :username => reserved_username
        user.should_not be_valid
        user.should have_at_least(1).error_on(:username)
      end
    end
  end
  describe "when authenticating with openid" do
    it "should generate user name if it is blank" do
      user = User.make_unsaved :username => nil
      user.should_receive(:authenticate_with_openid?).and_return(true)
      user.should be_valid
      user.username.should have_at_least(3).characters
    end
    it "should change user name if it is already taken" do
      existent_user = User.make
      user = User.make_unsaved :username => existent_user.username
      user.should_receive(:authenticate_with_openid?).and_return(true)
      user.should be_valid
      user.username.should =~ /^#{existent_user.username} \d+$/
    end
    User::RESERVED_USERNAMES.each do |reserved_username|
      it "should generate user name if it is reserved (\"#{reserved_username}\")" do
        user = User.make_unsaved :username => reserved_username
        user.should_receive(:authenticate_with_openid?).and_return(true)
        user.should be_valid
        user.username.should have_at_least(3).characters
      end
    end
  end


  it "should not change user name after update" do
    u = User.make
    expect {
      u.update_attribute :email, 'new@email.com'
    }.to_not change(u, :username)
  end
end
