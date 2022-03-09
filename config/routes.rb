Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users do
    resources :companies, only: %i[index show] do
      resources :clients, only: %i[index show] do
        resources :periods, only: %i[show] do
          get :invoice
          get :expense
        end
      end
    end
  end

  # Defines the root path route ("/")
  root 'home#welcome'
end
