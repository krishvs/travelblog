Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  resources :actions

  get 'homes/index'


  resources :blogs, :path => 'articles'
  get 'maps/:name', to: "maps#public_show"

  resources :trips do
    get 'collaborators', on: :member
    get 'add_collaborator', on: :member
    resources :folders, :path => 'f' do
      get 'activity', on: :member
      get 'timeline', on: :member
      resources :descriptions, :path => "blogs" do
        get "template", on: :collection
        post "update_template", on: :collection
      end
      resources :maps do
        resources :addresses
      end
      resources :costs
      resources :discussions do
        get 'add_comment', on: :member
      end
      resources :reminders
      resources :photos do
        get 'album_photos', on: :collection
      end
      resources :itenaries do
        resources :plans do
          get 'add_description', on: :member
          get 'add_discussion', on: :member
          get 'discussions', on: :member
          get 'add_map', on: :member
          get 'maps', on: :member
        end
      end
    end
    
    resources :user_actions
  end

  resources :documents


  resources :costs

  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords"}, skip: [:sessions, :registrations]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'homes#index'

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
  
  #->Prelang (user_login:devise/stylized_paths)
  devise_scope :user do
    get    "login"   => "users/sessions#new",         as: :new_user_session
    post   "login"   => "users/sessions#create",      as: :user_session
    delete "signout" => "users/sessions#destroy",     as: :destroy_user_session
    
    get    "signup"  => "users/registrations#new",    as: :new_user_registration
    post   "signup"  => "users/registrations#create", as: :user_registration
    put    "signup"  => "users/registrations#update", as: :update_user_registration
    get    "account" => "users/registrations#edit",   as: :edit_user_registration
  end

end
