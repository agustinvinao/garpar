Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users do
    resources :companies, only: %i[index show]
  end

  # Defines the root path route ("/")
  root 'home#welcome'
end
