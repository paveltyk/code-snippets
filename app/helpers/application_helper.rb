module ApplicationHelper
  def render_flash
    returning String.new do |html|
      flash.each do |type, message|
        html << content_tag(:div, message, :class => type)
      end
    end
  end
end
