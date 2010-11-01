class SnippetsController < ApplicationController
  def index
    @snippets = Snippet.paginate :page => params[:page], :per_page => 7, :order => 'snippets.created_at DESC', :include => :user

    respond_to do |format|
      format.html
    end
  end

  def show
    @snippet = Snippet.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def rss
    @snippets = Snippet.all :order => 'snippets.created_at DESC', :include => :user

    respond_to do |format|
      format.xml
    end
  end
  
end
