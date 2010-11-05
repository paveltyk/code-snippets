require 'spec_helper'

describe UserSessionsController do
  setup :activate_authlogic

  describe "routing" do
    it "should know the route to /login GET" do
      params_from(:get, '/login').should == { :controller => 'user_sessions', :action => 'new' }
    end
    it "should know the route to /login POST" do
      params_from(:post, '/login').should == { :controller => 'user_sessions', :action => 'create' }
    end
    it "should know the route to /logout GET" do
      params_from(:get, '/logout').should == { :controller => 'user_sessions', :action => 'destroy' }
    end
  end

  describe "#new" do
    it "should assign @user_session variable" do
      get :new
      assigns[:user_session].should be_an_instance_of(UserSession)
    end
  end

  describe "#create" do
    it "should set notice and redirect to root_url if openid identifier is valid (for existent user)" do
      user = User.make :openid_identifier => 'http://localhost:1123/john.doe?openid.success=true'
      stub_authenticate_by_openid :url => user.openid_identifier
      post :create, :user_session => { :openid_identifier => user.openid_identifier }
      controller.session["user_credentials"].should eql(user.persistence_token)
    end
    it "should create new user if openid identifier not exist yet" do
      stub_authenticate_by_openid 'email' => 'some@email.com'
      expect {
        post :create, :user_session => { :openid_identifier => "http://someone.example.com" }
      }.to change(User, :count).by(1)
    end
    it "should automatically log in new user" do
      stub_authenticate_by_openid 'email' => 'some@email.com'
      post :create, :user_session => { :openid_identifier => "http://someone.example.com" }
      controller.session["user_credentials"].should eql(User.last.persistence_token)
    end
    it "should render action \"new\" if credentials not valid" do
      post :create
      response.should render_template('new')
      controller.session["user_credentials"].should be_nil
    end
    it "should render action \"new\" if open id authentication failed" do
      stub_authenticate_by_openid :success => false
      post :create, :user_session => { :openid_identifier => "http://someone.example.com" }
      response.should render_template('new')
      controller.session["user_credentials"].should be_nil
    end
  end

  describe "#destroy" do
    it "should destroy the session if it's present, set notice and redirect if logged in" do
      user_session = double('user_session')
      UserSession.should_receive(:find).and_return(user_session)
      user_session.should_receive(:destroy).and_return(nil)
      get :destroy
      flash[:notice].should =~ /Successfully logged out/
      response.should be_redirect
    end

    it "should set notice and redirect if not logged in" do
      UserSession.should_receive(:find).and_return(nil)
      get :destroy
      flash[:notice].should =~ /You haven't logged in/
      response.should be_redirect
    end

  end

end
