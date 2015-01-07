Rails.application.routes.draw do

  get 'home/index'
  get 'home/auth'

  devise_for :users, controllers: {
      omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :drafts
  resources :items, only: %i(show)
  resources :users, only: %i(show) do
    resources :stocks, only: %i(index)
  end

  authenticated :user do
    root :to => "home#index", as: 'user_authenticated_root'
  end

  root 'home#auth'

end
