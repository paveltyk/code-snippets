class TagsController < ApplicationController
  def index
    @snippets = Snippet.paginate options_for_find_wit_tag.merge(:page => params[:page], :per_page => 7, :order => 'created_at DESC')
    render :template => 'snippets/index'
  end

  private

  def options_for_find_wit_tag
    Snippet.find_options_for_find_tagged_with params[:tag_name]
  end

end
