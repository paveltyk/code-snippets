require 'spec_helper'

describe HomeController do

  describe "routing" do
    it "should know the route to /home GET" do
      params_from(:get, '/home').should == {:controller => 'home', :action => 'index'}
    end
  end
  context "with views" do
    integrate_views
    
    describe "#index" do
      it "should get index" do
        get :index
        assert_response :success
      end
    end
  end
end