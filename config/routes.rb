# frozen_string_literal: true

Rails.application.routes.draw do
  get 'spendings/index'
  get 'spendings/show'
  get 'spendings/new'
  get 'spendings/edit'

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "homes#index"

  resources :groups, only: [:index], :path => 'home'
  resources :groups
  resources :spendings
end
