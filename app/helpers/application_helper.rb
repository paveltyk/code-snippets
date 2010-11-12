module ApplicationHelper
  include TagsHelper
  def render_flash
    returning String.new do |html|
      flash.each do |type, message|
        html << content_tag(:div, message, :class => type)
      end
    end
  end
  def follow_link(user = nil)
    user ||= @user
    return if current_user.present? && current_user == user
    if current_user.try(:following?, user)
      return link_to 'Unfollow', unfollow_path(user), :class => 'button', :method => :delete
    else
      return link_to 'Follow', follow_path(user), :class => 'button', :method => :post
    end
  end
end
