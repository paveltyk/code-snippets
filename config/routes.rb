ActionController::Routing::Routes.draw do |map|

  map.root :controller => "snippets"

  map.rss 'snippets.rss', :controller => 'snippets', :action => 'rss'
  map.home 'home', :controller => 'home', :action => 'index', :conditions => { :method => :get }

  map.with_options :controller => 'user_sessions' do |us|
    us.login 'login', :action => 'new', :conditions => { :method => :get }
    us.user_sessions 'login',:action => 'create', :conditions => { :method => :post }
    us.logout 'logout', :action => 'destroy'
  end

  map.tag 'tag/:tag_name', :controller => 'tags', :action => 'index'

  map.resources :snippets, :only => [:index, :show]

  map.namespace :my do |my|
    my.resources :snippets, :only => [:index, :new, :create, :edit, :update, :destroy]
  end

  map.with_options :controller => 'users' do |u|
    u.users 'users', :action => 'index', :conditions => {:method => :get}
    u.edit_profile 'my/profile', :action => 'edit', :conditions => {:method => :get}
    u.user ':id', :action => 'update', :conditions => {:method => :put}
    u.user ':id', :action => 'show', :conditions => {:method => :get}
    u.user ':id', :action => 'update', :conditions => {:method => :put}
  end

  map.with_options :controller => 'relationships' do |r|
    r.follow 'follow/:user_permalink', :action => 'create', :conditions => {:method => :post}
    r.unfollow 'unfollow/:user_permalink', :action => 'destroy', :conditions => {:method => :delete}
  end

end
