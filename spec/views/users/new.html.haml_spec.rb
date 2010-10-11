require 'spec_helper'

describe "View /users/new" do
  it "should not fail if @user variable set" do
    assigns[:user] = User.new
    render 'users/new'
    response.should be_success
  end
end