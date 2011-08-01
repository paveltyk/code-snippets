module SnippetsHelper
  def render_tag_list(tag_list)
    tag_list.map{ |tag| link_to tag, tag_path(tag), :title => tag }.join(' ')
  end

  def title_for_snippets_index
    text_array = []
    case params[:controller]
    when 'tags'
      text_array << "Tag: #{params[:tag_name]}"
    when 'users'
      text_array << @user.username
    when 'my/snippets'
      text_array << 'My Snippets'
    end

    text_array << "Page #{params[:page]}" if params[:page].present?
    text_array.delete_if(&:blank?)
    text_array.join(' | ') unless text_array.blank?
  end
end

