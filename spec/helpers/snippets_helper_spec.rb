require 'spec_helper'

describe SnippetsHelper do
  describe "#render_tag_list" do
    it "should return string with generated links" do
      tag_list = TagList.new "Tag1, Tag2", :parse => true
      helper.render_tag_list(tag_list).scan(/<a /i).size.should eql(2)
    end
  end
end