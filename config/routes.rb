Rails.application.routes.draw do
  resources :notes

  resources :meal_logs

  resources :pictures

  resources :categories

  resources :tables

  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }
  scope "/admin" do
    resources :users
  end

  resources :meals do
    resources :menus
  end
  put 'meals/:id/select_menu', to: "meals#select_menu"

  resources :dishes

  resources :menus do
    resources :dishes, controller: 'menu_dishes', only: [:index, :create, :destroy]
  end
  resource :dishes do
    resources :menus, controller: 'dish_menus', only: [:index, :create, :destroy]
  end

  resources :shifts
  resources :seating_chart_categories
  resources :comments

  root to: 'main#index', constraints: -> (r) { r.env["warden"].authenticate? }, as: :authenticate_root
  root to: 'main#cover'

  devise_scope :user do
    get "users/crop", to: "users/registrations#crop"
    get "users/choose-table", to: "users/registrations#choose_table"
    get "users/choose-vegan-table", to: "users/registrations#choose_vegan_table"
    put "users/join-table", to: "users/registrations#join_table"
    put "users/leave-table", to: "users/registrations#leave_table"
  end

  get "view-table/:id", to: "tables#view_table"
  get "view-table-seats-status/:id", to: "meal_logs#track_data"
  get "refresh-data/:id", to: "meal_logs#refresh_track_data"
  get "list-tables/:shift_id", to: "tables#list_tables"
  get "list-vegan-tables/:shift_id", to: "tables#list_vegan_tables"
  get "list-table-names/:shift_id", to: "tables#list_table_names"
  get "category/:id/dishes", to: "categories#list_dishes"

  get 'menu_dishes', to: "menu_dishes#index"
  post 'menu_dishes', to: "menu_dishes#create"
  delete 'menu_dishes', to: "menu_dishes#destroy"
  get 'dish_menus', to: "dish_menus#index"
  post 'dish_menus', to: "dish_menus#create"
  delete 'dish_menus', to: "dish_menus#destroy"

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
