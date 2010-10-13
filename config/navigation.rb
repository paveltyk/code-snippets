SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :register, 'Register', register_path, :if => Proc.new { !current_user }
    primary.item :login, 'Log In', login_path, :if => Proc.new { !current_user }
    primary.item :logout, 'Log Out', logout_path, :if => Proc.new { current_user }
    primary.item :snippets, 'Snippets', user_snippets_path(:current)
  end
end