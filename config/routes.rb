Rails.application.routes.draw do
  resources :keys, only: [:create]
  resources :messages, except: [:new, :edit]
  resources :members, except: [:new, :edit]
  resources :junior_enterprises, except: [:new, :edit]
  resources :users, except: [:new, :edit]

  post '/feedback' => 'messages#feedback'
  put 'messages/read/:id' => 'messages#read'

  get '/search' => 'junior_enterprises#search'
  get '/junior_enterprises/:id/members' => 'junior_enterprises#find_members'
  get '/junior_enterprises/:id/messages' => 'junior_enterprises#find_messages'
  post '/junior_enterprises/:id/seal' => 'junior_enterprises#seal'

  get '/users/:id/junior_enterprises' => 'users#find_junior_enterprise'
  post '/recover' => 'users#recover_email'
  get '/log_in' => 'users#log_in'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   



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
