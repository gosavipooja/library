Rails.application.routes.draw do


  get "rooms/add", :to => "rooms#add"

  get "rooms/edit", :to => "rooms#edit"

  get "rooms/index", :to => "rooms#index"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  resources :members

  root :to => "sessions#login"
  get "signup", :to => "members#index"
  get "login", :to => "sessions#login"
  post "login_attempt", :to => "sessions#login_attempt"
  get "createadmin", :to => "members#create_admin"
  get "showadmins", :to => "members#show_admin"
  get "logout", :to => "sessions#logout"
  get "home", :to => "sessions#home"
  get "adminhome", :to => "sessions#adminhome"
  get "profile", :to => "sessions#profile"
  get "setting", :to => "sessions#setting"
  get "logout", :to => "sessions#logout"

  post "rooms/add"
  post "rooms/create" => "rooms#create"
  resources :rooms, :only => [:add, :create]
  match '/rooms' => 'rooms#add', :via => :post
  resources :rooms do
    collection do
      get 'showall'

    end
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
