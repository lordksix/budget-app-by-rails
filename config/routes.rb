# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "homes#index"

  resources :homes, only: [:index], :path => 'home'
  resources :groups, only: [:index, :show, :new, :edit]
end
