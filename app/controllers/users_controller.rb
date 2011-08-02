class UsersController < ApplicationController
  before_filter :require_auth, :only => [:edit, :update]

  def index
    @users = User.paginate :per_page => 60, :page => params[:page], :order => 'users.username ASC'
  end

  def edit
    @user = current_user
  end

  def show
    @user = User.find_by_permalink!(params[:id])
    @snippets = @user.snippets.with_description_like(params[:q]).paginate :page => params[:page], :order => 'snippets.created_at DESC', :per_page => 7
    @tag_counts = @user.snippets.tag_counts

    respond_to do |format|
      format.html
      format.js { render :partial => 'snippets/snippets_list_with_pagination' }
    end
  end

  def update
    @user = current_user
    @user.attributes = params[:user]
    @user.save do |result|
      if result
        flash[:notice] = "Successfully updated profile."
        redirect_to edit_profile_path
      else
        render :action => 'edit'
      end
    end
  end
  
end