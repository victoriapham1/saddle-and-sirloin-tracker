Rails.application.routes.draw do
  root 'dashboards#show'

  # Routes for annoucements
  resources :announcements do
    member do
      get :delete
    end
  end

  # routes for user-events
  resources :user_event do
    member do
      post :create
      get :delete
    end
  end

  # Routes for committees
  resources :committees do
    member do
      get :delete
    end
  end

  resources :users do
    member do
      get :delete
    end
  end

  # Routes for events
  resources :events do
    member do
      get :delete
    end
  end

  match 'calendar', to: 'announcements#calendar', via: :get
  
  match 'swapRole', to: 'dashboards#swapRole', via: :put
  match 'waiting', to: 'users#waiting', via: :get
  match 'approve', to: 'users#approve', via: :put


  # OATH
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
