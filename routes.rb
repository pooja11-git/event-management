Rails.application.routes.draw do
  namespace :users do
    post 'signup', to: 'authentication#signup'
    post 'login', to: 'authentication#login'
  end
  
  resources :venues do
    resources :events, only: %i[index create] do
     get '/events/search', to: 'events#search'
    end

  end
  resources :events do
    resources :bookings, only: %i[create]

  end
  resources :bookings, only: %i[index update destroy] do
    member do
      put 'approve'
      put 'reject'
    end
  end
  
  
  
end
