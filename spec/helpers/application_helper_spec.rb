require 'spec_helper'

describe ApplicationHelper do
  it "should return html with flash wrapped in div with correct class" do
    helper.should_receive(:flash).and_return({ :flash_class => 'My Flash Message'})
    helper.render_flash.should have_tag("div.flash_class", 'My Flash Message')
  end
  context "with logged in user" do
    let(:user) { User.make }
    let(:current_user) { User.make }
    before(:each) { helper.stub :current_user => current_user }
    it "should return follow link" do
      helper.follow_link(user).should =~ />Follow</
    end
    it "should return unfollow link" do
      current_user.follow user
      helper.follow_link(user).should =~ />Unfollow</
    end
  end
  context "without logged in user" do
    before(:each) { helper.stub :current_user => nil }
    it "should return follow link" do
      helper.follow_link(User.make).should =~ />Follow</
    end
  end
  it "should set page title" do
    helper.should_receive(:content_for).once
    helper.title 'Page title'
  end
end
