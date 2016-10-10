Rails.application.routes.draw do

  resources :comments

  resource :posts

  resource :relationships, only: [:create, :destroy]

  resource :users, only: [:edit, :update] do
    member	do
      get :wish_frend, :del_wish_frend
      get :accept_frend, :not_accept_frend
    end
  end

  match 'likes',  to: 'likes#add_delete',    via: 'get', as: :likes_add_delete

  match 'users/show_new_friends',  to: 'users#show_new_friends',    via: 'get' , as: :show_users_new_friends
  match 'users/show_invites',  to: 'users#show_invites',    via: 'get' , as: :show_users_invites
  match 'users/show_wishes',  to: 'users#show_wishes',    via: 'get' , as: :show_users_wishes
  match 'users/show_friends',  to: 'users#show_friends',    via: 'get' , as: :show_users_friends

  match 'users/:id/show',  to: 'users#show',    via: 'get' , as: :show_users
  match 'users/index',  to: 'users#index',     via: 'get'

  devise_for :users
  root 'welcome#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
