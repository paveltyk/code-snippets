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
  def title(page_title)
    content_for(:title) { page_title }
  end

  def render_google_analytics
    <<EOD
<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-11357677-6']);
  _gaq.push(['_trackPageview']);
  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>
EOD
  end
end

