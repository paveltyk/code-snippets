SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.items do |primary|
    primary.item :tags, 'Search', search_path
    primary.item :new_snippet, 'New Snippet', new_my_snippet_path, :if => Proc.new { current_user }
    primary.item :snippets, 'My Snippets', my_snippets_path, :if => Proc.new { current_user }
    primary.item :login, 'Login', login_path, :if => Proc.new { !current_user }
    primary.item :register, 'Register', register_path, :if => Proc.new { !current_user }
    primary.item :logout, 'Logout', logout_path, :if => Proc.new { current_user }

    primary.dom_class = 'top-navigation'
  end
end