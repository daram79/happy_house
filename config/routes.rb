Rails.application.routes.draw do
  resources :lotteries do
    collection do
      post "create_lottery"
      put "update_lottery_tel_no"
      get "check_event"
      get "get_lottery_data"
    end
  end

  resources :logs do
    collection do
      post "create_log"
    end
  end

  resources :compatibilities
  
  resources :play_answers

  resources :plays

  resources :users do
    member do
      put "set_registration_id"
      get "get_alram_on"
      get "get_user_data"
      get "get_visitor_book"
      put "close_guide"
      put "get_visitor_book_read_flg"
      put "set_visitor_book_read_flg"
      post "add_like_user"
      get "get_like_user"
    end
    collection do
      get "agreement"
      get "personal_information_policy"
      get "notice"
      get "createVisitCount"
      post "create_visitor_book"
      get "get_user_list"
      get "chk_recommend_user_list"
    end
  end
  
  resources :user_covers do
    collection do
      post "add_name"
      get "get_image_url"
    end
    member do
      get "check_cover_name"
    end
  end
  
  resources :feeds do
    collection do
      get   "search_tag"
      delete  "destroy_feeds"
    end
    member do
      post "add_like"
      post "add_comment"
      get "comment"
    end
  end
  
  resources :populars
  
  resources :alrams do
    collection do
      get "get_alram_data"
      put "phone_alram_on"
      put "phone_alram_off"
    end
  end
  
  resources :member_notes do
    member do
      get "likes"
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'feeds#index'

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
