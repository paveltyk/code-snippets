require 'spec_helper'

describe UsersController do
  describe "routing" do
    it "should know the route to /register GET" do
      params_from(:get, '/register').should == { :controller => "users", :action => "new" }
    end

    it "should know the route to /register POST" do
      params_from(:post, '/register').should == { :controller => "users", :action => "create" }
    end
  end

  describe "#new" do
    it "should assign @user to new User object" do
      get :new
      assigns[:user].should be_an_instance_of(User)
    end
  end

  describe "#create" do
    let(:user) { double('user') }
    before(:each) { User.should_receive(:new).and_return(user) }

    it "should render action \"new\" if user not valid" do
      user.should_receive(:save).and_return(false)
      post :create
      response.should render_template('new')
    end

    it "should set notice and redirect if user is valid" do
      user.should_receive(:save).and_return(true)
      post :create
      response.should be_redirect
      flash[:notice].should_not be_blank
    end
  end

end