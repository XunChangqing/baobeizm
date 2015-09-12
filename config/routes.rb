Rails.application.routes.draw do
  get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'welcome#index'
  #post 'test_requesters' => 'test_requesters#create'
  #get 'test_requesters/:id', to: 'test_requesters#show', as: 'test_requester'
  #get 'test_requesters' => 'test_requesters#index'
  #post 'test_requesters/vote' => 'test_requesters#vote'
  
  get 'first_price_bargain/show' => 'first_price_bargain#show', as: :first_price_bargain_show
  get 'first_price_bargain/show_joiners' => 'first_price_bargain#show_joiners', as: :fpb_joiner
  get 'first_price_bargain/show_voters' => 'first_price_bargain#show_voters', as: :fpb_voter
  post 'first_price_bargain/join' => 'first_price_bargain#join', as: :first_price_bargain_join
  post 'first_price_bargain/vote' => 'first_price_bargain#vote', as: :first_price_bargain_vote
  get 'first_price_bargain/index_joiners' => 'first_price_bargain#index_joiners', as: :fpb_joiners_index
  get 'first_price_bargain/index_voters' => 'first_price_bargain#index_voters', as: :fpb_voters_index

  get 'paris_price_bargain/show' => 'paris_price_bargain#show', as: :paris_price_bargain_show
  get 'paris_price_bargain/index' => 'paris_price_bargain#index', as: :paris_price_bargain_index
  post 'paris_price_bargain/vote' => 'paris_price_bargain#vote', as: :paris_price_bargain_vote
  get 'paris_price_bargain/export' => 'paris_price_bargain#export', as: :paris_price_bargain_export
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
