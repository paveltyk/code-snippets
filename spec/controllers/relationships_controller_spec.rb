require 'spec_helper'

describe RelationshipsController do
  describe "routing" do
    it "should know the route to CREATE" do
      params_from(:post, '/follow/username').should == {:controller => 'relationships' ,:action => 'create', :user_permalink => 'username'}
    end
    it "should know the route to DESTROY" do
      params_from(:delete, '/unfollow/username').should == {:controller => 'relationships' ,:action => 'destroy', :user_permalink => 'username'}
    end
  end
  describe "without logged in user" do
    {:create => :post, :destroy => :delete}.each_pair do |action, method|
      it "##{action} should redirect to \"login\" page" do
        send method, action, :user_permalink => 1
        response.should redirect_to(login_path)
      end
    end
  end
  describe "with logged in user" do
    let(:current_user) { User.make }
    before(:each) do
      controller.stub :current_user => current_user
      request.env["HTTP_REFERER"] = snippets_path
    end
    describe "#create" do
      it "should create relationship and redirect back" do
        expect {
          post :create, :user_permalink => User.make.permalink
        }.to change(Relationship, :count).by(1)
        response.should redirect_to(snippets_path)
      end
      it "should set flash error and redirect back" do
        current_user.should_receive(:follow).and_return(Relationship.new)
        expect {
          post :create, :user_permalink => User.make.permalink
        }.to_not change(Relationship, :count)
        response.should redirect_to(snippets_path)
        flash[:error].should_not be_blank
      end
    end
    describe "#destroy" do
      it "should destroy relationship and redirect back" do
        user = User.make
        current_user.follow(user)
        expect {
          delete :destroy, :user_permalink => user.permalink
        }.to change(Relationship, :count).from(1).to(0)
        response.should redirect_to(snippets_path)
      end
    end
  end
end