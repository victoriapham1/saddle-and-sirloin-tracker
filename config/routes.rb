Rails.application.routes.draw do
  root "dashboards#show"

  resources :announcements do 
    member do
      get :delete
    end
  end

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
  
  resources :pollings do 
    member do
      get :delete
    end
  end
  
  resources :users
  
  match 'calendar', to: 'announcements#calendar', via: :get

  #OATH
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :events do
    member do
      get :delete
    end
  end
end
