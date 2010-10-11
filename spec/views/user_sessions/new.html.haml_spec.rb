require 'spec_helper'

describe "View /user_sessions/new" do
  setup :activate_authlogic

  it "should not fail if @user_session is set" do
    assigns[:user_session] = UserSession.new
    response.should be_success
    render 'user_sessions/new'
  end
end
