Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:new,:create,:show]
  resource :session, only: [:new,:create,:destroy]
  resources :bands 
  resources :albums 
  resources :tracks, only: [:create,:edit,:show,:update,:destroy]

  resources :albums, only: [] do
    resources :tracks, only: [:new]
  end

end
