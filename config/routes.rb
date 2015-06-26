Rails.application.routes.draw do
  resources :pictures

  resources :categories

  resources :tables

  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }
  scope "/admin" do
    resources :users
  end

  resources :meals
  resources :dishes
  resources :shifts

  root to: 'main#index'

  devise_scope :user do
    get "users/crop", to: "users/registrations#crop"
    get "users/choose-table", to: "users/registrations#choose_table"
    get "users/choose-vegan-table", to: "users/registrations#choose_vegan_table"
    put "users/join-table", to: "users/registrations#join_table"
    put "users/leave-table", to: "users/registrations#leave_table"
  end

  get "view-table/:id", to: "tables#view_table"
  get "list-tables/:shift_id", to: "tables#list_tables"
  get "list-vegan-tables/:shift_id", to: "tables#list_vegan_tables"
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
