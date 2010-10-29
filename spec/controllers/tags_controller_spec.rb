require 'spec_helper'

describe TagsController do

  describe "routing" do
    it "should know the search route" do
      params_from(:get, '/search').should == { :controller => 'tags', :action => 'search' }
    end
    it "should know the route to tag" do
      params_from(:get, '/tag/name').should == { :controller => 'tags', :action => 'index', :tag_name => 'name'}
    end
  end

  context "integrated with views" do
    integrate_views

    describe "GET 'index'" do
      it "should render \"index\" template" do
        get :index, :tag_name => 'rails'
        response.should render_template('snippets/index')
      end
      it "should render snippets only with given tag" do
        2.times { Snippet.make :tag_list => "rails, other_tag" }
        Snippet.make :tag_list => "other_tag"
        get :index, :tag_name => 'rails'
        assigns[:snippets].all?{ |s| s.tag_list.include?('rails') }.should be_true
      end
    end

    describe "GET search" do
      it "should render \"search\" template" do
        get :search
        response.should render_template('tags/search')
      end
      it "should assign tag counts" do
        get :search
        assigns[:tag_counts].should_not be_nil
      end
    end

  end

end
