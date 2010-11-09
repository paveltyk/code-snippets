ActionController::Routing::Routes.draw do |map|

  map.root :controller => "snippets"

  map.rss 'snippets.rss', :controller => 'snippets', :action => 'rss'
  map.home 'home', :controller => 'home', :action => 'index', :conditions => { :method => :get }

  map.login 'login', :controller => 'user_sessions', :action => 'new', :conditions => { :method => :get }
  map.user_sessions 'login', :controller => 'user_sessions', :action => 'create', :conditions => { :method => :post }
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'

  map.tag 'tag/:tag_name', :controller => 'tags', :action => 'index'

  map.resources :users, :only => [:index, :edit, :update]
  map.resources :snippets, :only => [:index, :show]

  map.namespace :my do |my|
    my.resources :snippets, :only => [:index, :new, :create, :edit, :update, :destroy]
  end

  map.user ':id', :controller => 'users', :action => 'show', :conditions => {:method => :get}
  map.user ':id', :controller => 'users', :action => 'update', :conditions => {:method => :put}

end
