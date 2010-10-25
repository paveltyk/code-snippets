require 'spec_helper'

describe UsersController do
  describe "routing" do
    it "shoul know the route to /users GET" do
      params_from(:get, '/users').should == { :controller => "users", :action => "index" }
    end
    it "should know the route to /register GET" do
      params_from(:get, '/register').should == { :controller => "users", :action => "new" }
    end
    it "should know the route to /register POST" do
      params_from(:post, '/register').should == { :controller => "users", :action => "create" }
    end
    it "should know the route to /users/1/edit GET" do
      params_from(:get, '/users/1/edit').should == { :controller => "users", :action => "edit", :id => '1' }
    end
    it "should know the route to /users/1 PUT" do
      params_from(:put, '/users/1').should == { :controller => "users", :action => "update", :id => '1' }
    end
  end
  context "with views" do
    integrate_views

    describe "#index" do
      it "should render view" do
        get :index
        response.should render_template('users/index')
      end
      it "should assign users array" do
        get :index
        assigns[:users].should_not be_nil
      end
    end

    describe "#new" do
      it "should assign @user to new User object" do
        get :new
        assigns[:user].should be_an_instance_of(User)
      end
    end

    describe "#create" do
      let(:user) { User.make_unsaved }
      it "should render action \"new\" if user not valid" do
        user.should_receive(:valid?).and_return(false)
        User.should_receive(:new).and_return(user)
        post :create
        response.should render_template('new')
      end

      it "should set notice and redirect if user is valid" do
        user.should_receive(:valid?).and_return(true)
        User.should_receive(:new).and_return(user)
        post :create
        response.should be_redirect
        flash[:notice].should_not be_blank
      end
    end

    context "with logged in user" do
      setup :activate_authlogic

      let(:user) { User.make }
      before(:each) { UserSession.create(user) }

      describe "#edit" do
        it "load current user" do
          get :edit, :id => 1
          assigns[:user].should eql(user)
        end
      end

      describe "#update" do
        it "should update user and redirect" do
          user.should_receive(:save).and_yield(true)
          controller.should_receive(:current_user).at_least(1).and_return(user)
          put :update, :id => 1
          response.should be_redirect
        end
      end
    end
  end

end