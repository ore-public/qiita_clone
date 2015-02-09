Rails.application.routes.draw do

  get 'home/index'
  get 'home/auth'

  devise_for :users, controllers: {
      omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :drafts
  resources :items, only: %i(show index) do
    namespace :items do
      resource :stock, only: %i(create destroy)
    end
    resources :comments, except: %i(show)
  end
  resources :users, only: %i(show) do
    namespace :users do
      resources :stocks, only: %i(index)
    end
    resource :follow, only: %i(create destroy)
  end

  resources :tags, only: %i(show) do
    resource :tag_follow, only: %i(create destroy)
  end

  authenticated :user do
    root :to => "home#index", as: 'user_authenticated_root'
  end

  root 'home#auth'

end
