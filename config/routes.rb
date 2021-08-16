# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/login', to: 'devise/sessions#new'
    post '/login', to: 'devise/sessions#create'
    delete '/logout', to: 'devise/sessions#destroy'
  end
  root 'static_pages#home'

  resources :receipts, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
