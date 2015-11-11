Rails.application.routes.draw do

  # get 'items/index'
  # get 'items/new'
  # get 'items/show'
  # get 'items/edit'
  authenticated :user do
    # root :to => "users#show"
    root :to => "welcome#index"
  end

  unauthenticated :user do
    root :to => "welcome#index", as: 'unauthenticated_root'
  end

  devise_for :users #do 
  resources :items

  get 'items/:id/done', to: 'items#done', as: "item_done"
  get 'items/:id/redo', to: 'items#redo', as: "item_redo"

  #, only: [:create]
  #end

  # get 'users/index'
  # get 'users/show'
  # get 'users/update'
  resources :users, only: [:update, :show, :index] # Not sure why this does not work.  Error in Application Layout.  If change to User_Path still has issues.
  # http://guides.rubyonrails.org/routing.html
  # See Section 2.6 -> needed to add (:id)
  
  get 'about' => 'welcome#about'
  # root :to=>"welcome#index"

  # get 'item_done' => 'items#done'

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
