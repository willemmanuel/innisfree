Rails.application.routes.draw do


 #get "/innisfree/" => redirect("/appointments")

  resources :cars
  put 'cars/:id/toggle' => 'cars#toggle',  as: :toggle_car
  put 'settings/admin/:id' => 'settings#toggle_user_permission', as: :admin_user
  put 'settings/approve/:id' => 'settings#toggle_user_approval', as: :approve_user
  post 'settings/create_user' => 'settings#create_user', as: :create_user
  get 'appointments/upcoming' => 'appointments#upcoming'
  get 'appointments/appointments_for_day' => 'appointments#appointments_for_day'
  get 'reports/generate' => 'reports#generate'
  get 'users/send_reminders' => 'users#send_reminders', as: :send_reminders


  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :appointments do
    collection do
      get 'update_residents', to: 'appointments#update_residents'
    end
  end



  resources :doctors

  resources :residents, except: [:index]

  resources :houses

  resources :users
  
  resources :reports do
    collection do
      get 'update_doctors', to: 'reports#update_doctors'
    end
  end

  root 'appointments#index'
  
  get 'admin' => 'settings#index', as: :settings

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
