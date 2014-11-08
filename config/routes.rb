Rails.application.routes.draw do
  get 'drafts/new'

  root 'home#index'

  get 'home/index'

  devise_for :users, controllers: {
      omniauth_callbacks: "users/omniauth_callbacks"
  }

end
