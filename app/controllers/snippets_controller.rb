class SnippetsController < ApplicationController
  def index
    @snippets = Snippet.paginate :page => params[:page], :per_page => 7, :order => 'snippets.created_at DESC'

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
end
