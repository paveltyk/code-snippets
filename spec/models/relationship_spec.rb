require 'spec_helper'

describe Relationship do
  it "should create a relationship" do
    expect {
      Relationship.create! :follower => User.make, :followed => User.make
    }.to change(Relationship, :count).by(1)
  end
  context "with blank relationship" do
    let(:relationship) { Relationship.new }
    it "should not be valid if \"follower\" attr is nil" do
      relationship.should_not be_valid
      relationship.should have_at_least(1).error_on(:follower)
    end
    it "should not be valid if \"followed\" attr is nil" do
      relationship.should_not be_valid
      relationship.should have_at_least(1).error_on(:followed)
    end
    it "should not be valid if \"follower\" == \"followed\"" do
      relationship.follower = relationship.followed = User.make
      relationship.should_not be_valid
      relationship.should have(1).error
      relationship.errors.full_messages.should include("Follower and Followed can't be the same person")
    end
  end
end