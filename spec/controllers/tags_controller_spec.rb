require 'spec_helper'

describe TagsController do

  context "integrated with views" do
    integrate_views

    describe "GET 'index'" do
      it "should be successful" do
        get :index, :tag_name => 'rails'
        response.should be_success
      end
      it "should render snippets only with given tag" do
        2.times { Snippet.make :tag_list => "rails, other_tag" }
        Snippet.make :tag_list => "other_tag"
        get :index, :tag_name => 'rails'
        assigns[:snippets].all?{ |s| s.tag_list.include?('rails') }.should be_true
      end
    end

  end

end
