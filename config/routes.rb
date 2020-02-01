Rails.application.routes.draw do
  devise_for :users
  resources :movies do
    collection do
      get 'search'
    end
    resources :reviews
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  get '/movies/:id/next', to: 'movies#next'
  get '/movies/:id/prev', to: 'movies#prev'
end
