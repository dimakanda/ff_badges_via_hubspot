Dummy::Application.routes.draw do
  resources :badges

  # login and signup
  #----------------------------------------------------------------------

  get 'login'  => 'sessions#new',     as: 'login'
  get 'logout' => 'sessions#destroy', as: 'logout'
  get 'signup' => 'users#new',        as: 'signup'

  resources :sessions

  # resources :users do
  #   get :activate, on: :member
  #   get :activate_new_email, on: :member
  # end

  # resources :password_resets, only: [:create, :edit, :update, :new]

  # resource :settings do
  #   post :update_email
  #   post :send_new_email_activation
  #   post :cancel_new_email
  #   post :destroy_avatar
  # end

  # resources :blog,  controller: 'blog'

  # admin
  #----------------------------------------------------------------------

  namespace :admin do
    resources :badges

    root to: "dashboard#show"
    # resources :subscribers

    # resources :users, only: [:index, :new, :create, :destroy] do
    #   get :activate, on: :member
    #   get :deactivate, on: :member
    #   get :impersonate, on: :member
    #   get :stop_impersonating, on: :collection
    #   put :admin_remove, on: :member
    #   put :admin_make, on: :member
    # end

    # namespace :blog do
    #   root to: "posts#index"
    #   resources :posts do
    #     post :preview_markdown, on: :collection
    #   end
    # end
  end

  root to: 'site#index'

end
