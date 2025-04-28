Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  get '/login', to: 'users#login', as: :login
  # to allow testers to easily logout without FE functionality
  if Rails.env.development?
    get '/logout', to: 'users#logout', as: :logout
  end
  post '/users', to: 'users#create', as: :create_user
  
  # Vote routes
  # Currently no index voting page
  resources :elections, param: :slug, only: [:show] do
    # Nested routes for votes and results
    get 'vote', to: 'votes#new', as: :vote
    resources :votes, only: [:create]
    get 'results', to: 'results#show'
  end

end
