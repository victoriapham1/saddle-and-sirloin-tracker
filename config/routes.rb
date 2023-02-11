Rails.application.routes.draw do
  root "books#index"
  resources :books do 
    member do
      get :delete
    end
  end

  resources :committees do 
    member do
      get :delete
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
