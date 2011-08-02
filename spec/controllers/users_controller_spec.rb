require 'spec_helper'

describe UsersController do
  describe "routing" do
    it "shoul know the route to /users GET" do
      params_from(:get, '/users').should == { :controller => "users", :action => "index" }
    end
    it "should know the route to /my/profile GET" do
      params_from(:get, '/my/profile').should == { :controller => "users", :action => "edit" }
    end
    it "should know the route to /user-name PUT" do
      params_from(:put, '/user-name').should == { :controller => "users", :action => "update", :id => 'user-name' }
    end
    it "should know the route to SHOW" do
      params_from(:get, '/user-name').should == { :controller => "users", :action => "show", :id => 'user-name' }
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
        it "should update user and redirect to edit_profile_path" do
          user.should_receive(:save).and_yield(true)
          controller.should_receive(:current_user).at_least(1).and_return(user)
          put :update, :id => 1
          response.should redirect_to(edit_profile_path)
        end
      end
    end

    describe "#show" do
      it "should assign snippets owned by user" do
        user = User.make
        snippet = Snippet.make :user => user
        get :show, :id => user.to_param
        assigns[:snippets].should eql([snippet])
        response.should be_success
      end
    end
  end

end