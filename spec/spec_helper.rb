ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
require 'spec/autorun'
require 'spec/rails'
require 'authlogic/test_case'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

Spec::Runner.configure do |config|
  config.before(:all)    { Sham.reset(:before_all)  }
  config.before(:each)   { Sham.reset(:before_each) }
  config.before(:each, :type => :controller) { controller.stub!(:authenticate_with_open_id).and_raise('Please stub your openid requests with "stub_authenticate_by_openid" helper method.') }
end

class ActiveSupport::TestCase
  def stub_authenticate_by_openid(opts = {})
    success = opts.delete(:success) || true
    url = opts.delete(:url) || "http://my_dummy.openid.com"
    OpenID.stub(:normalize_url).and_return(url)
    result = stub('result', :unsuccessful? => !success)
    controller.stub!(:authenticate_with_open_id).and_yield(result, url, opts)
  end
end
