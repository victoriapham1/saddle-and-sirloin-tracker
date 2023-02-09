Rails.application.routes.draw do
  root "books#index"
  resources :books do 
    member do
      get :delete
    end
  end
  
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
