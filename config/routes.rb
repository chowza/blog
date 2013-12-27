Blog::Application.routes.draw do

  resources :articles, :except => :show

  root :to => 'articles#index' 
  match 'about', to: 'static_pages#about'

  match 'tableofcontents', to: 'articles#tableofcontents'
  

  match "/articles" => redirect("/")
  match "/articles/" => redirect("/")


  # Get /articles/2012/?page=1
  match "/articles/:year", :to => "articles#index",
  :constraints => { :year => /\d{4}/ }, :as=> :posts_year

  # Get /articles/2012/07/?page=1
  match "/articles/:year/:month", :to => "articles#index",
  :constraints => { :year => /\d{4}/, :month => /\d{1,2}/ }, :as => :posts_month
  
  # Get /articles/2012/07/slug-of-the-post
  match "/articles/:year/:month/:slug", :to => "articles#show", 
  :constraints => { :year => /\d{4}/, :month => /\d{1,2}/, :slug => /[a-z0-9\-]+/ }, :as => :posts_date


### Redirecting for errors ###

  # if there is a letter in the year, then it's an error
  match "/articles/:year", :to => "articles#errors",
  :constraints => { :year => /\D+/}, :as => :posts_errors

  # if there's a letter in the year, then it's an error
  match "/articles/:year/:month", :to => "articles#errors",
  :constraints => { :year => /\D+/, :month => /.+/ }, :as => :posts_errors

  # if the year is not 4 digits it's an error, (the below works because it has already checked if year has 4 digits)
  match "/articles/:year", :to => "articles#errors",
  :constraints => { :year => /\d+/}, :as => :posts_errors

  # if the year is not 4 digits its an error
  match "/articles/:year/:month", :to => "articles#errors",
  :constraints => { :year => /\d+/, :month => /.+/ }, :as => :posts_errors
  
  # if there's a letter in the month, then it's an error
  match "/articles/:year/:month", :to => "articles#errors",
  :constraints => { :year => /\d{4}/, :month => /\D+/ }, :as => :posts_errors

####

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
  # match ':controller(/:action(/:id))(.:format)'
end
