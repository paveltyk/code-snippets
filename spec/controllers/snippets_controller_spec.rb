require 'spec_helper'

describe SnippetsController do
  setup :activate_authlogic

  describe "routing" do
    it "should know the route to /users/1/snippets GET" do
      params_from(:get, '/users/1/snippets').should == { :controller => 'snippets', :action => 'index', :user_id => '1' }
    end
    it "should know the route to /users/1/snippets/new GET" do
      params_from(:get, '/users/1/snippets/new').should == { :controller => 'snippets', :action => 'new', :user_id => '1' }
    end
    it "should know the route to /users/1/snippets POST" do
      params_from(:post, '/users/1/snippets').should == { :controller => 'snippets', :action => 'create', :user_id => '1' }
    end
    it "should know the route to /users/1/snippets/2 GET" do
      params_from(:get, '/users/1/snippets/2').should == { :controller => 'snippets', :action => 'show', :user_id => '1', :id => '2' }
    end
    it "should know the route to /users/1/snippets/2/edit GET" do
      params_from(:get, '/users/1/snippets/2/edit').should == { :controller => 'snippets', :action => 'edit', :user_id => '1', :id => '2' }
    end
    it "should know the route to /users/1/snippets/2 PUT" do
      params_from(:put, '/users/1/snippets/2').should == { :controller => 'snippets', :action => 'update', :user_id => '1', :id => '2' }
    end
    it "should know the route to /users/1/snippets/2 DELETE" do
      params_from(:delete, '/users/1/snippets/2').should == { :controller => 'snippets', :action => 'destroy', :user_id => '1', :id => '2' }
    end
  end

  describe "with logged in user" do
    integrate_views
    let(:user) { User.make }
    before(:each) { UserSession.create(user) }
    describe "#index" do
      it "should get all user snippets" do
        3.times { user.snippets.make }
        2.times { Snippet.make }
        get :index, :user_id => user.id
        assigns[:snippets].size.should eql(3)
        Snippet.count.should eql(5)
      end
    end
    describe "#show" do
      it "should load snippet" do
        snippet = user.snippets.make
        get :show, :user_id => user.id, :id => snippet.id
        assigns[:snippet].should eql(snippet)
      end
    end
    describe "#new" do
      it "should build new snippet" do
        get :new, :user_id => 1
        assigns[:snippet].should_not be_nil
      end
    end
    describe "#create" do
      it "should create new snippet and redirect" do
        expect {
          post :create, :user_id => user.id, :snippet => Snippet.plan
        }.to change { user.snippets.count }.from(0).to(1)
        response.should be_redirect
      end
    end
    describe "#edit" do
      it "should find snippet" do
        snippet = user.snippets.make
        get :edit, :user_id => user.id, :id => snippet.id
        assigns[:snippet].should eql(snippet)
      end
    end
    describe "#update" do
      it "should update snippet and redirect" do
        snippet = user.snippets.make
        put :update, :user_id => user.id, :id => snippet.id, :snippet => { :title => 'New title'}
        user.snippets.find(snippet.id).title.should eql('New title')
        response.should be_redirect
      end
    end
    describe "#destroy" do
      it "should destroy snippet and redirect" do
        snippet = user.snippets.make
        expect {
          delete :destroy, :user_id => user.id, :id => snippet.id
        }.to change { user.snippets.count }.from(1).to(0)
        response.should be_redirect
      end
    end
  end
end
