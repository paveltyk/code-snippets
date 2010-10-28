require 'spec_helper'
require 'digest/md5'

describe GravatarHelper do
  let(:user) { User.make_unsaved }

  it "should set correct src attribute" do
    encoded_email = Digest::MD5.hexdigest(user.email)
    helper.gravatar_for(user).should =~ /src="http:\/\/www\.gravatar\.com\/avatar\/#{encoded_email}\S*"/i
  end
  it "should set username as alt attribute" do
    helper.gravatar_for(user).should =~ /alt="#{CGI::escape(user.username)}"/i
  end
  it "should set username as title attribute" do
    helper.gravatar_for(user).should =~ /title="#{CGI::escape(user.username)}"/i
  end
end