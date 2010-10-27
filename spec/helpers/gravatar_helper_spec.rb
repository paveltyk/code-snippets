require 'spec_helper'

describe GravatarHelper do

  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(GravatarHelper)
  end

  it "should return image_tag correct format" do
  end

end