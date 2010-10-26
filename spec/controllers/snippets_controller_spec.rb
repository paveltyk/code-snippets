require 'spec_helper'

describe SnippetsController do

  describe "routing" do
    it "should know the route to INDEX" do
      params_from(:get, '/snippets').should == { :controller => 'snippets', :action => 'index' }
    end
    it "should know the route to SHOW" do
      params_from(:get, '/snippets/1').should == { :controller => 'snippets', :action => 'show', :id => '1' }
    end
  end

  describe "with views integrated" do
    integrate_views

    describe "#index" do
      it "should assign snippets" do
        get :index
        assigns[:snippets].should_not be_nil
      end
    end

    describe "#show" do
      it "should find and assign snippet" do
        snippet = Snippet.make
        Snippet.should_receive(:find).and_return(snippet)
        get :show, :id => '1'
        assigns[:snippet].should eql(snippet)
      end
    end

  end

end
