Rails.application.routes.draw do
  resources :badges

  namespace :admin do
    resources :badges, except: [:show]
  end

end
