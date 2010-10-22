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
    let(:user) { User.make :password => 'password' }

    it "should render action \"new\" if credentials not valid" do
      post :create
      response.should render_template('new')
    end
    it "should set notice and redirect to home_url if credentials are valid" do
      post :create, :user_session => { :username => user.username, :password => 'password' }
      flash[:notice].should_not be_blank
      response.should redirect_to(home_url)
    end
    it "should login by email as well" do
      post :create, :user_session => { :username => user.email, :password => 'password' }
      assert_equal controller.session["user_credentials"], user.persistence_token
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
