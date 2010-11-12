class RelationshipsController < ApplicationController
  before_filter :require_auth

  def create
    relationship = current_user.follow(user)
    flash[:error] = relationship.errors.full_messages.join(" ") unless relationship.valid?
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def destroy
    current_user.unfollow(user)
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  private

  def user
    @user ||= User.find_by_permalink!(params[:user_permalink])
  end

end
