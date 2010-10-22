class SnippetsController < ApplicationController
  before_filter :require_user

  def index
    @snippets = current_user.snippets.all :order => 'snippets.created_at DESC'

    respond_to do |format|
      format.html
    end
  end

  def show
    @snippet = current_user.snippets.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @snippet = Snippet.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @snippet = current_user.snippets.find(params[:id])
  end

  def create
    @snippet = current_user.snippets.new(params[:snippet])

    respond_to do |format|
      if @snippet.save
        format.html { redirect_to([current_user, @snippet], :notice => 'Snippet was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @snippet = current_user.snippets.find(params[:id])

    respond_to do |format|
      if @snippet.update_attributes(params[:snippet])
        format.html { redirect_to([current_user, @snippet], :notice => 'Snippet was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @snippet = current_user.snippets.find(params[:id])
    @snippet.destroy

    respond_to do |format|
      format.html { redirect_to user_snippets_url(current_user) }
    end
  end
end
