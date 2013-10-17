Dummy::Application.routes.draw do
  resources :badges

  # login and signup
  #----------------------------------------------------------------------

  get 'login'  => 'sessions#new',     as: 'login'
  get 'logout' => 'sessions#destroy', as: 'logout'
  get 'signup' => 'users#new',        as: 'signup'

  resources :sessions

  # admin
  #----------------------------------------------------------------------

  namespace :admin do
    resources :badges

    root to: "dashboard#show"
  end

  root to: 'site#index'

end
