class TagsController < ApplicationController
  def index
    @snippets = Snippet.with_description_like(params[:q]).paginate options_for_find_wit_tag.merge(:page => params[:page], :per_page => 7, :order => 'created_at DESC', :include => :user)
    @tag_counts = []

    respond_to do |format|
      format.html { render :template => 'snippets/index' }
      format.js { render :partial => 'snippets/snippets_list_with_pagination' }
    end
  end

  private

  def options_for_find_wit_tag
    Snippet.find_options_for_find_tagged_with params[:tag_name]
  end

end
