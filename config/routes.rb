# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'forecasts#index'
  post '/forecasts/search', to: 'forecasts#search'
  resources :temperatures, only: [:new, :create]
end
