require 'spec_helper'

describe My::SnippetsController do
  setup :activate_authlogic

  describe "routing" do
    it "should know the route to INDEX" do
      params_from(:get, '/my/snippets').should == { :controller => 'my/snippets', :action => 'index' }
    end
    it "should know the route to NEW" do
      params_from(:get, '/my/snippets/new').should == { :controller => 'my/snippets', :action => 'new' }
    end
    it "should know the route to CREATE" do
      params_from(:post, '/my/snippets').should == { :controller => 'my/snippets', :action => 'create' }
    end
    it "should know the route to EDIT" do
      params_from(:get, '/my/snippets/2/edit').should == { :controller => 'my/snippets', :action => 'edit', :id => '2' }
    end
    it "should know the route to UPDATE" do
      params_from(:put, '/my/snippets/2').should == { :controller => 'my/snippets', :action => 'update', :id => '2' }
    end
    it "should know the route to DESTROY" do
      params_from(:delete, '/my/snippets/2').should == { :controller => 'my/snippets', :action => 'destroy', :id => '2' }
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
        get :index
        assigns[:snippets].size.should eql(3)
        Snippet.count.should eql(5)
      end
    end

    describe "#new" do
      it "should build new snippet" do
        get :new
        assigns[:snippet].should_not be_nil
      end
    end

    describe "#create" do
      it "should create new snippet and redirect" do
        expect {
          post :create, :snippet => Snippet.plan
        }.to change { user.snippets.count }.from(0).to(1)
        response.should redirect_to(my_snippets_path)
      end
    end

    describe "#edit" do
      it "should find snippet" do
        snippet = user.snippets.make
        get :edit, :id => snippet.id
        assigns[:snippet].should eql(snippet)
      end
    end

    describe "#update" do
      it "should update snippet and redirect" do
        snippet = user.snippets.make
        put :update, :id => snippet.id, :snippet => { :description => 'New description'}
        user.snippets.find(snippet.id).description.should eql('New description')
        response.should redirect_to(snippet_path(snippet))
      end
    end

    describe "#destroy" do
      it "should destroy snippet and redirect" do
        snippet = user.snippets.make
        expect {
          delete :destroy, :id => snippet.id
        }.to change { user.snippets.count }.from(1).to(0)
        response.should redirect_to(my_snippets_path)
      end

    end
  end

  describe "authorization" do
    let(:snippet) { Snippet.make }
    before(:each) { snippet.reload; UserSession.create(User.make) }

    it "should not allow to modify snippet" do
      expect { put :update, :id => snippet.id }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should not allow to edit snippet" do
      expect { get :edit, :id => snippet.id }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should not allow to destroy snippet" do
      expect { delete :destroy, :id => snippet.id }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

end
