require 'spec_helper'

describe Snippet do
  describe "#title" do
    it "should be equal to the first line of description" do
      snippet = Snippet.make_unsaved :description => "First line of the description.\nSecond line of the description."
      snippet.title.should eql('First line of the description.')
    end
    it "should be truncated description if the first line too long" do
      snippet = Snippet.make_unsaved :description => "q"*100
      snippet.title.should eql("q"*60)
    end
    it "should be default title if description is blank" do
      snippet = Snippet.make :description => nil
      snippet.title.should eql("Code Snippet ##{snippet.id}")
    end
  end

  describe "validation" do
    it "should not be valid with blank code" do
      snippet = Snippet.make_unsaved :code => nil
      snippet.should_not be_valid
      snippet.should have_at_least(1).error_on(:code)
    end
    it "should not be valid with blank user" do
      snippet = Snippet.make_unsaved :user => nil
      snippet.should_not be_valid
      snippet.should have_at_least(1).error_on(:user)
    end
  end

  describe "#description_html" do
    it "should return html for valid markdown" do
      snippet = Snippet.make_unsaved :description => '**Bold** *Italic*'
      snippet.description_html.should eql("<p><strong>Bold</strong> <em>Italic</em></p>\n")
    end
    it "should return description if description blank" do
      snippet = Snippet.make_unsaved :description => nil
      snippet.description_html.should be_nil
    end
  end
end