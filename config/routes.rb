ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  
  map.root :controller => "snippets"

  map.resources :users
  map.resources :snippets, :only => [:index, :show]

  map.namespace :my do |my|
    my.resources :snippets, :only => [:index, :new, :create, :edit, :update, :destroy]
  end

  map.home 'home', :controller => 'home', :action => 'index', :conditions => { :method => :get }
  map.register 'register', :controller => 'users', :action => 'new', :conditions => { :method => :get }
  map.users 'register', :controller => 'users', :action => 'create', :conditions => { :method => :post }

  map.login 'login', :controller => 'user_sessions', :action => 'new', :conditions => { :method => :get }
  map.user_sessions 'login', :controller => 'user_sessions', :action => 'create', :conditions => { :method => :post }
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'

  map.tag 'tag/:tag_name', :controller => 'tags', :action => 'index'

end
