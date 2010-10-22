SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.items do |primary|
    primary.item :snippets, 'My Snippets', user_snippets_path(:current), :if => Proc.new { current_user } do |sub_nav|
      sub_nav.item :snippets, 'New Snippet', new_user_snippet_path(:current), :if => Proc.new { current_user }
    end
    primary.item :login, 'Log In', login_path, :if => Proc.new { !current_user }
    primary.item :register, 'Register', register_path, :if => Proc.new { !current_user }
    primary.item :logout, 'Log Out', logout_path, :if => Proc.new { current_user }
  end
end