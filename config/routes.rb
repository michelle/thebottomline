Thebottomline::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  match 'register' => 'register#new', :via => :get, :as => :register
  match 'register' => 'register#create', :via => :post

  match 'settings' => 'settings#index', :via => :get, :as => :settings
  match 'settings' => 'settings#update', :via => :post
  
  match 'logout' => 'login#logout', :via => :get, :as => :logout
  match 'login' => 'login#index', :via => :get, :as => :login
  match 'login' => 'login#login', :via => :post
  match 'forgot' => 'login#forgot_password', :via => :get, :as => :forgot
  match 'forgot' => 'login#send_password', :via => :post
  match 'forgot' => 'login#send_password', :via => :post
  
  # Send controller
  match 'send' => 'send#index', :via => :get, :as => :send
  match 'send/postcard' => 'send#postcard_new', :via => :get, :as => :send_postcard
  match 'send/postcard' => 'send#postcard_create', :via => :post
  match 'send/ecard' => 'send#ecard_new', :via => :get, :as => :send_ecard
  match 'send/ecard' => 'send#ecard_create', :via => :post
  
  match 'admin' => 'admin#index', :via => :get, :as => :admin
  match 'admin/newsletter'=> 'admin#send_newsletter', :via => :post
  
  match 'help' => 'welcome#help', :as => :help
  match 'about' => 'welcome#about', :as => :about
  match 'mission' => 'welcome#mission', :as => :mission
  root :to => 'welcome#index', :as => :welcome
  
end
