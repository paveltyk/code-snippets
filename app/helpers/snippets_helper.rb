module SnippetsHelper
  def render_tag_list(tag_list)
    tag_list.map{ |tag| link_to tag, tag_path(tag), :title => tag }.join(' ')
  end
end
