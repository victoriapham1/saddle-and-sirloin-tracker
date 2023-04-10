# frozen_string_literal: true

Rails.application.routes.draw do
  root 'dashboards#show'

  # Routes for annoucements
  resources :announcements do
    member do
      get :delete
    end
  end

  # routes for user-events
  resources :user_event, path: 'user_event/:event_id/', only: [:new] do
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

  # Routes for users
  resources :users do
    member do
      get :delete
    end
    collection do
      put :update_multiple
    end
  end

  # Routes for events
  resources :events do
    member do
      get :delete
      get :previous
    end
  end

  match 'calendar', to: 'announcements#calendar', via: :get

  match 'like', to: 'dashboards#like', via: :get

  match 'waiting', to: 'users#waiting', via: :get

  match 'confirm', to: 'users#confirm', via: :get

  # OATH
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
