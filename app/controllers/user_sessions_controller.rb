class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.save do |result|
      if result
        redirect_to root_path
      else
        render :action => 'new'
      end
    end
    render :action => 'new' unless performed?
  end

  def destroy
    if @user_session = UserSession.find
      @user_session.destroy
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

end
