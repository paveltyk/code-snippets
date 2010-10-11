require 'spec_helper'

describe ApplicationHelper do
  it "should return html with flash wrapped with div with correct class" do
    helper.should_receive(:flash).and_return({ :flash_class => 'My Flash Message'})
    helper.render_flash.should have_tag("div.flash_class", 'My Flash Message')
  end
end
